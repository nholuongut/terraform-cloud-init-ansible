resource "aws_ssm_parameter" "cloudwatch_windows" {
  count = "${var.ENABLE_AWS_MANAGEMENT_AGENTS == "true" ? 1 : 0}"
  type = "String"
  name = "AmazonCloudWatch-windows"
  overwrite = true
  value = "${file("${path.module}/files/cw-windows.json")}"
}

resource "aws_ssm_parameter" "cloudwatch_linux" {
  count = "${var.ENABLE_AWS_MANAGEMENT_AGENTS == "true" ? 1 : 0}"
  type = "String"
  name = "AmazonCloudWatch-linux"
  overwrite = true
  value = "${file("${path.module}/files/cw-linux.json")}"
}

resource "aws_ssm_parameter" "ansible_git" {
  name = "/ansible/common/git/private_key"
  count = "${var.STORE_ANSIBLE_GIT_KEY == "true" ? 1 : 0}"
  description = "Ansible git user private key"
  type = "SecureString"
  overwrite = true
  value = "${data.local_file.ansible_git.content}"
  tags {
    Environment = "${var.ENV}"
  }
}
