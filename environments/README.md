# Environments

This directory contains the base configurations for each Delve AWS account.  Configurations are written in Terraform and Terragrunt, and orchestrated via GitHub Actions. The Terraform code within this directory structure creates and maintains state for core regional and global infrastructure necessary to build Delve's development, testing and production workflows.

## Directory Structure

The directory structure is organized by account, and then by region. The intention with this directory structure is to allow the operator to easily vizualize the core infrastructure configurations for each account and easily implement new configurations across all environments.

Example structure:

```
environments
├── _envcommon
│   ├── global_base_infra.hcl
│   └── regional_base_infra.hcl
├── development-1
│   ├── us-east-1
│   │   ├── infra
│   │   │   └── terragrunt.hcl
│   │   └── region.hcl
│   ├── account.hcl
│   └── env.hcl
├── common.hcl
└── terragrunt.hcl
```
The `_envcommon/` directory contains repeatable invocations of the Terraform modules in `Infrastructure/tf_modules`. It is also possible in future iterations to invoke modules from remote sources like GitHub.

## Terragrunt in Action

Terragrunt traverses directories using a hierarchical configuration approach, allowing for more organized and modular infrastructure code. When executing a command, Terragrunt searches for a terragrunt.hcl configuration file in the current working directory and then recursively walks up the directory tree to find additional terragrunt.hcl files in parent directories. This hierarchical traversal enables users to compose configurations and apply settings at different levels of granularity.

Note that at the root of the `environments` directory and in `environments/development-1/us-east-1/infra` directory exists a `terragrunt.hcl` file. When running `terragrunt plan` in the `environments/development-1/us-east-1/infra`, Terragrunt traverses back up the directory tree to the root `terragrunt.hcl` file, which contains detailed configuration for remote state backends, providers, and what files to parse for additional configuration throughout the tree.

This also results in a well-organized remote state structure.  Whereas by solely using Terraform, the operator would need to create a bucket and either utilize `terraform workspaces` or manual effort to create bucket subdirectories, Terragrunt manages this automatically.  Terragrunt can even create the base bucket if it doesn't exist.

An `apply` operation would result in the following structure in AWS S3:

`<base-bucket-name>/<us-east-1>/<infra>/tfstate.json`

If more `terragrunt.hcl` files are added to apply configuration at different levels of the directory structure, than additional `tfstate.json` files would be saved to the appropriate directory rather than one large state file, limiting the blast radius of future issues.

Behind the scenes, Terragrunt creates a temporary cache directory and generates all of the configuration files needed to successfully run the cooresponding `terraform` command.  By doing so, the operator can write reusable code which imports configurations at different levels of granularity.