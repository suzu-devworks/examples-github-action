# OAuth 2.0 and OpenID Connect (OIDC) Authentication

## Overview

Learn how GitHub Actions can completely eliminate static passwords (such as private key JSON) and use OIDC (OpenID Connect) Token Exchange (RFC 8693) to securely access GCP (Google Cloud) resources.
You can experience the essence of OIDC authentication by using curl to reproduce the "raw HTTP communication" behind the scenes that is automated by the official Action.

With Auth0, I couldn't set up token exchange from the management screen, so I gave up.

## Authentication from GitHub Actions using GCP's Workload Identity Federation

### What is Workload Identity integration?

Workload Identity integration is a mechanism that securely changes OIDC ID tokens issued by external ID providers (such as GitHub and AWS) to temporary access tokens in the cloud (such as Google Cloud) through token exchange based on OAuth 2.0 specifications (RFC 8693), eliminating the need to manage long-term private keys.

- [Workload Identity Federation - Google Cloud Documentation](https://docs.cloud.google.com/iam/docs/workload-identity-federation?hl=ja)

### Step 1. Settings on GCP (Google Cloud) side

All operations can be completed using the browser's management screen (console).

#### 1. Create a service account

  1. Open "IAM & Management" > "Service Accounts" in the GCP console.
  2. Click Create Service Account.
  3. Enter any name (e.g. github-actions-study) and click "Create and continue".
  4. Assign the following roles (permissions) to the service account and click "Done".
     - "Browser" (roles/browser) Required for the project describe API.
       - Required privilege: `resourcemanager.projects.get`
     - "Service Usage Viewer" (roles/serviceusage.serviceUsageViewer) Required for the service list API.
       - Required privilege: `serviceusage.services.list`
     - "Storage Viewer" (roles/storage.viewer) Required for the Cloud Storage bucket list API.
       - Required privilege: `storage.buckets.list`
  5. Make a note of the email address of the service account created.

  If you're doing it via the command line:

  ```bash
  # Create a service account
  gcloud iam service-accounts create github-actions-study \
      --project="{PROJECT ID}" \
      --description="Service account for GitHub Actions OIDC authentication" \
      --display-name="github-actions-study" 

  # Assign roles to the service account
  gcloud projects add-iam-policy-binding "{PROJECT ID}" \
      --member="serviceAccount:github-actions-study@{PROJECT ID}.iam.gserviceaccount.com" \
      --role="roles/browser"
  ```

#### 2. Workload Identity linkage (token exchange office) settings

  1. Open "IAM and Management" > "Workload Identity Integration" from the left menu.
  2. Click “Create a pool” and enter `github-pool` as the name and click Next.
  3. Enter the following on the Add Provider screen.
     - Provider selection: `OpenID Connect (OIDC)`
     - Provider name: `github-provider`
     - Publisher (URL): `https://token.actions.githubusercontent.com`
     - Audience: Leave the default selected and continue.

  4. Configure attribute mapping.  
     - `google.subject` = `assertion.sub`
     - `attribute.repository` = `assertion.repository`

  5. Configure attribute conditions.
     - `assertion.repository_id=="{GITHUB REPOSITORY_ID}"`
     > [!NOTE]
     > Using name attributes such as `repository` or `repository_owner` presents an attack risk, so numeric attributes such as `*_id` are recommended.

  6. Click Save. Make a note of the numerical part of the project number from the complete resource name of "Provider" displayed on the screen (projects/[project number]/...).

  If you're doing it via the command line:

  ```bash
  # Create a workload identity pool
  gcloud iam workload-identity-pools create github-pool \
      --project="{PROJECT ID}" \
      --location="global" \
      --display-name="GitHub Actions OIDC Pool"

  # Create a workload identity provider
  gcloud iam workload-identity-pools providers create-oidc github-provider \
      --project="{PROJECT ID}" \
      --location="global" \
      --workload-identity-pool="github-pool" \
      --display-name="GitHub Actions OIDC Provider" \
      --issuer-uri="https://token.actions.githubusercontent.com" \
      --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository" \
      --attribute-condition="assertion.repository_id==\"{GITHUB REPOSITORY_ID}\""
  ```

  You can find the `{GITHUB REPOSITORY_ID}` in the repository's meta tags or by using the following command:

  ```bash
  curl -s https://api.github.com/repos/{username}/{repository} | jq '{id, name}'
  ```

  or

  ```bash
  gh api repos/{username}/{repository} --jq '{id, name}'
  ```

#### 3. Permission to access service account (building trust relationship)

  1. On the details screen for the pool you created, click "Allow access" at the top.
  2. Under Select Service Account, select the service account you created earlier.
  3. Select "Subset in pool" and enter the attribute name `repository` and the value exactly as your GitHub "username/repository".
  4. Click Save.

  If you're doing it via the command line:

  ```bash
  # Allow access to the service account from the workload identity pool
  gcloud iam service-accounts add-iam-policy-binding github-actions-study@{PROJECT ID}.iam.gserviceaccount.com \
      --project="{PROJECT ID}" \
      --role="roles/iam.workloadIdentityUser" \
      --member="principalSet://iam.googleapis.com/projects/{PROJECT NUMBER}/locations/global/workloadIdentityPools/github-pool/attribute.repository/{GITHUB REPOSITORY}"
  ```

### Step 2. Register Secrets on GitHub

Play it safe and hide and manage all GCP infrastructure configuration information in a secret repository.

  1. Open Settings > Secrets and variables > Actions in your GitHub repository.
  2. Click "New repository secret" and register all five below.

| Name to register (half-width uppercase letters) | Value to set (example/confirmation method) |
| --- | --- |
| GCP_PROJECT_NUMBER | Project number displayed on the GCP console (numbers only) |
| GCP_PROJECT_ID | Project ID displayed in the GCP console (string) |
| GCP_POOL_ID | github-pool |
| GCP_PROVIDER_ID | github-provider |
| GCP_SA_EMAIL | Email address of the service account you created |

### Step 3. Deploy the GitHub Actions workflow

Place the sample workflow in [.github/workflows/articles-oidc-authentication.yaml](.github/workflows/articles-oidc-authentication.yaml) in the repository.
When starting manually (workflow_dispatch), you can test by switching between official action (action) and raw HTTP request (curl).

### Step 4. Try it out

  1. Open the Actions tab of your GitHub repository.
  2. Select “GCP_OIDC_Method_Comparison” from the left menu.
  3. Press the "Run workflow" button on the right side of the screen, select the authentication method (action or curl), and execute.
  4. After the execution is complete, open the logs and confirm that access to the GCP side is successful even though we have not passed any static passwords.

## References

- [Configuring OpenID Connect in Google Cloud Platform - GitHub Docs](https://docs.github.com/ja/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-google-cloud-platform)
- [Configure Workload Identity Federation with deployment pipelines &nbsp;|&nbsp; Identity and Access Management (IAM) &nbsp;|&nbsp; Google Cloud Documentation](https://docs.cloud.google.com/iam/docs/workload-identity-federation-with-deployment-pipelines?hl=ja#github-actions)
