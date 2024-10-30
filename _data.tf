provider "aws" {}
provider "local" {}

data "aws_caller_identity" "current" {}

data "template_file" "redhat" {
  template = "${file("${path.module}/files/redhat.txt")}"
  vars {
    ORG = "${var.ORG}"
    ENV = "${var.ENV}"
    HOSTGROUP= "${var.HOSTGROUP}"
    ANSIBLE_PLAYBOOKS_REPO = "${var.ANSIBLE_PLAYBOOKS_REPO}"
    ANSIBLE_SEED_VARS = "${var.ANSIBLE_SEED_VARS}"
  }
}

data "template_file" "centos" {
  template = "${file("${path.module}/files/centos.txt")}"
  vars {
    ORG = "${var.ORG}"
    ENV = "${var.ENV}"
    HOSTGROUP= "${var.HOSTGROUP}"
    ANSIBLE_PLAYBOOKS_REPO = "${var.ANSIBLE_PLAYBOOKS_REPO}"
    ANSIBLE_SEED_VARS = "${var.ANSIBLE_SEED_VARS}"
  }
}

data "template_file" "debian" {
  template = "${file("${path.module}/files/debian.txt")}"
  vars {
    ORG = "${var.ORG}"
    ENV = "${var.ENV}"
    HOSTGROUP = "${var.HOSTGROUP}"
    ANSIBLE_PLAYBOOKS_REPO = "${var.ANSIBLE_PLAYBOOKS_REPO}"
    ANSIBLE_SEED_VARS = "${var.ANSIBLE_SEED_VARS}"
  }
}

output "redhat_user_data" {
  value = "${data.template_file.redhat.rendered}"
}

output "centos_user_data" {
  value = "${data.template_file.centos.rendered}"
}

output "debian_user_data" {
  value = "${data.template_file.debian.rendered}"
}
