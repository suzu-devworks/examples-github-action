# examples-github-action

[![CodeQL](https://github.com/suzu-devworks/examples-github-action/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/suzu-devworks/examples-github-action/actions/workflows/github-code-scanning/codeql)

## What is the purpose of this repository?

This repository is a personal playground for the author to learn and experiment with Github Actions.

The content may also be useful for other developers facing similar issues.

However, please note that the code is based on the author's personal understanding and may contain errors or inaccuracies.

## Index

- Chapter 1 - Basics of GitHub Actions
  - [Hello World](./.github/workflows/go.yaml)
- Chapter 2 - Hands-on CI/CD implementation
  - [Implement CI using pull request triggers](./.github/workflows/ci.yaml)
  - [Implement CD functionality using a merge-based approach](./.github/workflows/cd.yaml)
- Chapter 3 - Features required for real-world deployments
  - [Available values ​​(context) within the workflow](./.github/workflows/context.yaml)
  - [Saving job outputs (artifacts) and passing them on to the next job](./.github/workflows/artifacts.yaml)
  - [Job and step execution control (Control Flow)](./.github/workflows/control-flow.yaml)
  - [Accelerating CI processes through cache utilization](./.github/workflows/cache.yaml)
  - [Workflow triggers](./.github/workflows/trigger.yaml)
  - [About GitHub Actions permissions](./.github/workflows/permissions.yaml)
- Chapter 4 - Challenges and solutions of using GitHub Actions in large-scale development
  - [Using containers via jobs](./.github/workflows/containers.yaml)
  - [Application of job execution using matrix strategy](./.github/workflows/matrix.yaml)
    - [Use case 1: Dividing tests](./.github/workflows/matrix-use-case1.yaml)
    - [Use case 2: Dynamically building jobs](./.github/workflows/matrix-use-case2.yaml)
  - [Control the timing of the cache](./.github/workflows/cache-restore.yaml)
- Chapter 5 - Workflow design for large-scale development
  - A workflow that takes maintainability into consideration
    - [Reuseable workflow (Playwright)](./.github/workflows/reusable-e2e-test.yaml)
  - Execute at various times
    - [When a pull request is opened](./.github/workflows/trigger-test-environment-create.yaml)
    - [When the pull request is updated](./.github/workflows/trigger-test-environment-update.yaml)
    - [When the pull request is closed](./.github/workflows/trigger-test-environment-destroy.yaml)
  - Workflow optimization
    - [Skip the job based on whether there are any changes](./.github/workflows/skips-if-no-changes-detected.yaml)
    - [Rerun only failed tests](./.github/workflows/rerun-only-failed-tests.yaml)

- Appendix
  - [11 Best Practices for GitHub Actions](./.github/workflows/ex-11-good-practices.yaml)

## References

- Software Design July 2024 - Gijutsu-Hyoron Co., Ltd
  - Special Feature 1 GitHub Actions 実践講座
<!-- spell-checker: words Gijutsu Hyoron -->