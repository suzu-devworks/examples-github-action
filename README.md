# examples-github-action

[![CodeQL](https://github.com/suzu-devworks/examples-github-action/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/suzu-devworks/examples-github-action/actions/workflows/github-code-scanning/codeql)

## What is the purpose of this repository?

This repository is just my personal playground for learning and experimenting with GitHub Actions.

The content here might actually be helpful to other developers facing similar issues.

However, please keep in mind that this code is based solely on my own perspective and probably has lots of
inaccurate or questionable parts!

## Examples

- Chapter 1 - Basics of GitHub Actions
  - [Hello World](./.github/workflows/chapter-1-hello.yaml)
- Chapter 2 - Hands-on CI/CD implementation
  - [Implement CI using pull request triggers](./.github/workflows/chapter-2-1-ci.yaml)
  - [Implement CD functionality using a merge-based approach](./.github/workflows/chapter-2-2-cd.yaml)
- Chapter 3 - Features required for real-world deployments
  - [Available values ​​(context) within the workflow](./.github/workflows/chapter-3-1-contexts.yaml)
  - [Saving job outputs (artifacts) and passing them on to the next job](./.github/workflows/chapter-3-2-artifacts.yaml)
  - [Job and step execution control (Control Flow)](./.github/workflows/chapter-3-3-control-flow.yaml)
  - [Accelerating CI processes through cache utilization](./.github/workflows/chapter-3-4-caching.yaml)
  - [Workflow triggers](./.github/workflows/chapter-3-5-triggers.yaml)
  - [About GitHub Actions permissions](./.github/workflows/chapter-3-6-permissions.yaml)
- Chapter 4 - Challenges and solutions of using GitHub Actions in large-scale development
  - [Using containers via jobs](./.github/workflows/chapter-4-1-containers.yaml)
  - [Application of job execution using matrix strategy](./.github/workflows/chapter-4-2-matrix.yaml)
    - [Use case 1: Test Splitting](./.github/workflows/chapter-4-2-matrix1-splitting.yaml)
    - [Use case 2: Dynamically building jobs](./.github/workflows/chapter-4-2-matrix2-dynamic.yaml)
  - [Control the timing of the cache](./.github/workflows/chapter-4-3-cache-handling.yaml)
- Chapter 5 - Workflow design for large-scale development
  - A workflow that takes maintainability into consideration
    - [Reuseable workflow (Caller)](./.github/workflows/chapter-5-1-e2e-test.yaml)
    - [Reuseable workflow (Playwright)](./.github/workflows/reusable-e2e-test.yaml)
    - [Custom action (setup-playwright)](./.github/actions/setup-playwright/action.yaml)
  - Execute at various times
    - [When a pull request is opened](./.github/workflows/chapter-5-2-timings1-test-environment-create.yaml)
    - [When the pull request is updated](./.github/workflows/chapter-5-2-timings2-test-environment-update.yaml)
    - [When the pull request is closed](./.github/workflows/chapter-5-2-timings3-test-environment-destroy.yaml)
  - Workflow optimization
    - [Skip the job based on whether there are any changes](./.github/workflows/chapter-5-3-skips-if-no-changes-detected.yaml)
    - [Rerun only failed tests](./.github/workflows/chapter-5-4-rerun-only-failed-tests.yaml)

- Articles
  - [Automatically detect changes and execute in parallel for each project](./.github/workflows/articles-changed-detection.yaml)
  - [Build and push multiplatform Docker images to GitHub Container Registry](./.github/workflows/articles-multi-platform-docker-build.yaml)
  - [OIDC authentication (Workload Identity federation)](./.github/workflows/articles-oidc-authentication.yaml)

- Appendix
  - [11 Best Practices for GitHub Actions](./.github/workflows/ex-11-good-practices.yaml)

## References

- Software Design July 2024 - Gijutsu-Hyoron Co., Ltd
  - Special Feature 1 GitHub Actions 実践講座
<!-- spell-checker: words Gijutsu Hyoron -->