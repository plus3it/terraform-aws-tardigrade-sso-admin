## terraform-aws-tardigrade-sso-admin

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### [2.0.1](https://github.com/plus3it/terraform-aws-tardigrade-sso-admin/releases/tag/2.0.1)

**Commit Delta**: n/a

**Released**: 2023.05.22

**Summary**:

* Uses *only* `permission_set_arn` when available to create the account assignment
* Fixes resource cycle when state already exists and new account assignments are
  added to the list

### 2.0.0

**Commit Delta**: n/a

**Released**: 2023.03.21

**Summary**:

* Updates to use AWS module 4.40.0
* Replaces "filter" with "alternate_identifier"

### 1.0.0

**Commit Delta**: n/a

**Released**: 2023.01.11

**Summary**:

* Provides initial capability for managing AWS SSO Permission Sets and Account
  Assignments
