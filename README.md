<!-- omit in toc -->
# Infrastructure Template

![GitHub top language](https://img.shields.io/github/languages/top/xebis/infrastructure-template)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

![GitHub](https://img.shields.io/github/license/xebis/infrastructure-template)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/xebis/infrastructure-template)
![GitHub issues](https://img.shields.io/github/issues/xebis/infrastructure-template)
![GitHub last commit](https://img.shields.io/github/last-commit/xebis/infrastructure-template)

Template for automated GitOps and IaC in a cloud.

GitLab CI handles static and dynamic environments. Environments are created, updated, and destroyed by Terraform, then configured by cloud-init and Ansible.

**The project is under active development.**

<!-- omit in toc -->
## The Goal

The goal is to have GitOps repository to automatically handle environments life cycle - its creation, update, configuration, and eventually destroy as well.

> GitOps = IaC + MRs + CI/CD

_[GitLab: What is GitOps?](https://about.gitlab.com/topics/gitops/)_

<!-- omit in toc -->
## Table of Contents

- [Features](#features)
- [Installation and Configuration](#installation-and-configuration)
  - [Set up GitLab CI](#set-up-gitlab-ci)
  - [Set up Local Usage](#set-up-local-usage)
- [Usage](#usage)
  - [GitLab CI](#gitlab-ci)
  - [Local Usage](#local-usage)
- [Contributing](#contributing)
  - [Testing](#testing)
  - [Operations](#operations)
- [To-Do list](#to-do-list)
- [Roadmap](#roadmap)
- [Credits and Acknowledgments](#credits-and-acknowledgments)
- [Copyright and Licensing](#copyright-and-licensing)
- [Changelog and News](#changelog-and-news)
- [Notes and References](#notes-and-references)
  - [Dependencies](#dependencies)
  - [Recommendations](#recommendations)
  - [Suggestions](#suggestions)
  - [Further Reading](#further-reading)

## Features

Automatically updates environments:

- On *release* tag runs `prod` environment update stub
- On `main` branch commit runs `stag` environment update stub
- On *pre-release* tag runs `test-<tag>` environment update stub
- On _non-_`main` branch commit runs `dev-<branch>` environment update stub

Manually managed environments:

- Create, update, or destroy any environment

Automatically checks conventional commits, validates Markdown, YAML, shell scripts, Terraform (HCL), releases, and so on. See [GitHub - xebis/repository-template: Well-manageable and well-maintainable repository template.](https://github.com/xebis/repository-template) for full feature list.

## Installation and Configuration

Get Hetzner Cloud API token:

- [Hetzner Cloud - referral link with €20 credit](https://hetzner.cloud/?ref=arhwlvW4nCxX)
  - Hetzner Cloud Console -> Projects -> *Your Project* -> Security -> API Tokens -> Generate API Token `Read & Write`

### Set up GitLab CI

- GitLab -> Settings
  - General > Visibility, project features, permissions > Operations: **on**
  - CI/CD > Variables > Add variable: Key `HCLOUD_TOKEN`, Value `<token>`

### Set up Local Usage

```shell
export GL_TOKEN="<token>" # Your GitLab's personal access token with the api scope
export TF_HTTP_PASSWORD="$GL_TOKEN" # Set password for Terraform HTTP backend
export HCLOUD_TOKEN="<token>" # Your Hetzner API token
export TF_TARGET_ENV_NAME="<environment>" # Replace with the target environment name
export TF_TARGET_ENV_SLUG="<env>" # Replace with the target environment slug
```

Install dependencies by `tools/setup-repo` script, update dependencies by `tools/setup-repo` script.

## Usage

### GitLab CI

- Push a _non-_`main` branch to create or update `dev-<branch>` environment stub
- Create *pre-release* tag to create `test-<tag>` environment stub
- Merge to `main` branch to create or update `stag` environment stub
- Have present a commit starting `feat` or `fix` from the previous release to create or update `prod` environment stub
- Commit and push to run validations

### Local Usage

Initialize local workspace if not yet initialized:

```shell
# Init local workspace
terraform init -reconfigure \
    -backend-config="address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_TARGET_ENV_SLUG" \
    -backend-config="lock_address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_TARGET_ENV_SLUG/lock" \
    -backend-config="unlock_address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_TARGET_ENV_SLUG/lock"
```

Work with Terraform as you need: `terraform validate/fmt/plan/apply/show/refresh/output/destroy`

Uninitialize local workspace if you wish:

```shell
rm -rf .terraform # Uninit local workspace, this step is required if you would like to work with another environment
```

Commit and push to run validations.

## Contributing

Please read [CONTRIBUTING](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting merge requests to us.

### Testing

\#TODO: *Testing stack and how to run tests.*

### Operations

\#TODO: *Operations.*

## To-Do list

- [ ] Replace `shfmt` exact version `v3.3.1` at [.gitlab-ci.yml](.gitlab-ci.yml) with `latest`

## Roadmap

- [ ] Speed up CI/CD with a set of Docker images with pre-installed dependencies for each CI/CD stage

## Credits and Acknowledgments

- [Martin Bružina](https://bruzina.cz/) - Author

## Copyright and Licensing

- [MIT License](LICENSE)
- Copyright © 2021 Martin Bružina

## Changelog and News

- [Changelog](CHANGELOG.md)

## Notes and References

### Dependencies

- [Hetzner Cloud - referral link with €20 credit](https://hetzner.cloud/?ref=arhwlvW4nCxX)
- [Terraform](https://www.terraform.io/)
  - [Terraform: Hetzner Cloud Provider](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs)
- [GitHub - xebis/repository-template: Well-manageable and well-maintainable repository template.](https://github.com/xebis/repository-template)

### Recommendations

- [GitHub - shuaibiyy/awesome-terraform](https://github.com/shuaibiyy/awesome-terraform)

### Suggestions

- [Visual Studio Code](https://code.visualstudio.com/) with [Extensions for Visual Studio Code](https://marketplace.visualstudio.com/VSCode):
  - [HashiCorp Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)

### Further Reading

- [GitLab: What is GitOps?](https://about.gitlab.com/topics/gitops/)
