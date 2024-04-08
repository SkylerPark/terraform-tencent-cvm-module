### MAC Install
echo "Package Install"
echo "Package pre-commit, tfenv, terraform-docs, jq, tflint, tfsec"
package_list="pre-commit tfenv terraform-docs jq tflint tfsec"

for package in $package_list; do
    check_package=`brew list | grep $package`
    if [ -z "check_package)" ]; then
        echo "brew install $package"
        brew install $package
    fi
done

### pre-commit config setup
echo "pre-commit conmfig setting"
cat <<EOF > .pre-commit-config.yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.88.0
    hooks:
      - id: terraform_fmt
      - id: terraform_tfsec
      - id: terraform_docs
        args:
          - "--args=--lockfile=false"
      - id: terraform_tflint
        args:
          - "--args=--only=terraform_deprecated_interpolation"
          - "--args=--only=terraform_deprecated_index"
          - "--args=--only=terraform_unused_declarations"
          - "--args=--only=terraform_comment_syntax"
          - "--args=--only=terraform_documented_outputs"
          - "--args=--only=terraform_documented_variables"
          - "--args=--only=terraform_typed_variables"
          - "--args=--only=terraform_module_pinned_source"
          - "--args=--only=terraform_naming_convention"
          - "--args=--only=terraform_required_version"
          - "--args=--only=terraform_required_providers"
          - "--args=--only=terraform_standard_module_structure"
          - "--args=--only=terraform_workspace_remote"
          - "--args=--only=terraform_unused_required_providers"
      - id: terraform_validate
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: check-merge-conflict
      - id: end-of-file-fixer
      - id: trailing-whitespace
  - repo: https://github.com/compilerla/conventional-pre-commit
    rev: v3.2.0
    hooks:
      - id: conventional-pre-commit
        stages: [commit-msg]
EOF

### pre-commit install
echo "pre-commit install"
pre-commit install
pre-commit install --hook-type commit-msg

### releaserc setting
echo "releaserc setting"
cat <<EOF > .releaserc.yaml
---
branches:
  - main
defaultBranch: "main"
preset: "angular"
tagFormat: "${version}"
plugins:
  - "@semantic-release/commit-analyzer"
  - "@semantic-release/release-notes-generator"
  - "@semantic-release/changelog"
  - "@semantic-release/git"
  - "@semantic-release/github"

verifyConditions:
  - "@semantic-release/github"

analyzeCommits:
  - path: "@semantic-release/commit-analyzer"
    releaseRules:
      - type: "feat"
        release: "minor"
      - type: "fix"
        release: "patch"
      - type: "breaking"
        release: "major"
      - type: "refactor"
        release: "patch"
      - type: "chore"
        release: "patch"

generateNotes:
  - path: "@semantic-release/release-notes-generator"
    writerOpts:
      groupBy: "type"
      commitGroupsSort:
        - "breaking"
        - "feat"
        - "fix"
        - "chore"
      commitsSort: "header"
    types:
      - type: "feat"
      - section: "Features"
      - type: "fix"
      - section: "Bug Fixes"
      - type: "breaking"
      - section: "Breaking Changes"
      - type: "refactor"
      - hidden: true
      - type: "chore"
      - section: "Chore"
      - type: "docs"
      - hidden: true
      - type: "doc"
      - hidden: true
      - type: "style"
      - hidden: true
      - type: "perf"
      - hidden: true
      - type: "test"
      - hidden: true
    presetConfig: true
prepare:
  - path: "@semantic-release/git"
  - path: "@semantic-release/changelog"
    changelogFile: "CHANGELOG.md"
publish:
  - path: "@semantic-release/github"

success:
  - "@semantic-release/github"

fail:
  - "@semantic-release/github"
EOF

### tflint setting
echo "tflint setting"
cat <<EOF > .tflint.hcl
plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"

  custom_formats = {
    extended_snake_case = {
      description = "Extended snake_case Format which allows double underscore like `a__b`."
      regex       = "^[a-z][a-z0-9]+([_]{1,2}[a-z0-9]+)*$"
    }
  }

  module {
    format = "extended_snake_case"
  }

  resource {
    format = "extended_snake_case"
  }

  data {
    format = "extended_snake_case"
  }
}

rule "terraform_unused_declarations" {
  enabled = false
}

rule "terraform_unused_required_providers" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = false
}

###################################################
# Rule Sets - AWS
###################################################

plugin "aws" {
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.21.1"

  enabled    = true
  deep_check = false
}
EOF

### gitignore setting
echo "gitignore update"
cat <<EOF > .gitignore
# Local .terraform directories
**/.terraform/*

# Terraform lockfile
.terraform.lock.hcl

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log

# Exclude all .tfvars files, which are likely to contain sentitive data, such as
# password, private keys, and other secrets. These should not be part of version
# control as they are data points which are potentially sensitive and subject
# to change depending on the environment.
*.tfvars

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Ignore CLI configuration files
.terraformrc
terraform.rc
EOF
