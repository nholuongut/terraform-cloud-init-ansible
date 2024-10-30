variable "ORG" { }
variable "ENV" { }
variable "HOSTGROUP" { default = "default" }
variable "ANSIBLE_PLAYBOOKS_REPO" { }
variable "ANSIBLE_SEED_VARS" { default = "" }

variable "STORE_ANSIBLE_GIT_KEY" { default = "false" }
variable "ANSIBLE_GIT_KEY" { default = "~/.ssh/ansible_rsa" }
variable "ENABLE_AWS_MANAGEMENT_AGENTS" { default = "true" }
variable "CREATE_AWS_MANAGEMENT_POLICY" { default = "false" }
