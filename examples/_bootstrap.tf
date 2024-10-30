variable "HOSTGROUP" { default = "default" }
variable "REPO" { default = "git@github.com:example/repo.git" }

# Just enabling the module with the following flags will create
# SSM parameters and IAM policies.
module "cloud_init_ansible" {
  source = ".."
  ENV = "${var.ENV}"
  ORG = "${var.ORG}"
  HOSTGROUP = "${var.HOSTGROUP}"
  REPO = "${var.REPO}"

  STORE_ANSIBLE_GIT_KEY = "true"
  ANSIBLE_GIT_KEY = "~/.ssh/ansible_rsa"
  ENABLE_AWS_MANAGEMENT_AGENTS = "true"
  CREATE_AWS_MANAGEMENT_PLICY = "true"
}
