#!/bin/bash
# Script to update all package dependencies for various languages and package managers.
workspace_dir=$(realpath "$(dirname "$0")/..")

# Update Go packages
echo "Update Go packages"
go -C ${workspace_dir}/chapters/go/hello-api/ get -u ./...

# Update Npm packages
echo "Update Npm packages"
pushd ${workspace_dir}/chapters/node/calc/ && npx -y npm-check-updates -u --target semver && npm install; popd;

echo "Update Npm(yarn v1) packages"
pushd ${workspace_dir}/chapters/node/calc-yarn/ && npx -y npm-check-updates -u --target semver && yarn install; popd;

echo "Update Npm(pnpm) packages"
pnpm --prefix ${workspace_dir}/chapters/e2e/ update
pnpm --prefix ${workspace_dir}/chapters/node/calc-pnpm/ update

# Update Nuget packages
echo "Update Nuget packages"
dotnet package update --project ${workspace_dir}/chapters/dotnet/HelloWorld/

echo "Update complete"
