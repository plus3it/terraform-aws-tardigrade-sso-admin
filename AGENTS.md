# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module manages AWS IAM Identity Center (SSO) permission sets and account assignments. The main input is the `sso_admin` object, which holds a list of `permission_sets` and a list of `account_assignments`. Each item needs a unique `name`. The outputs are `permission_sets` and `account_assignments`, which return the results of the two submodules. The module looks up the SSO instance, identity store, partition, and organization accounts with data sources.

### Module-specific files

- `modules/permission-set/` — Submodule that creates one SSO permission set with its inline policy and managed policy attachments; the root module calls it once per item in `permission_sets`
- `modules/account-assignment/` — Submodule that creates one SSO account assignment for a user or group and a target account; the root module calls it once per item in `account_assignments`
