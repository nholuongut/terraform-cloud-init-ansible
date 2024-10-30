data "local_file" "ansible_git" {
  filename = "${pathexpand(var.ANSIBLE_GIT_KEY)}"
}
