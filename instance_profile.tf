# The IAM instance profile
resource "aws_iam_instance_profile" "ansible_node" {
  name_prefix = "ansible"
  role = "${aws_iam_role.ansible_node.name}"
}

# Which gets bound to the IAM role, with a trust
# relationship to the ec2.amazonaws.com service
resource "aws_iam_role" "ansible_node" {
  name_prefix = "ansible"
  path = "/"

  # The trusted entity in the IAM role
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": "AssumeRole"
        }
    ]
}
EOF
}

# The policy statements get attached to the IAM role's
# policy, allowing instances that use sts:AssumeRole to
# use permission herein
resource "aws_iam_role_policy_attachment" "get_ssm_parameter" {
  role       = "${aws_iam_role.ansible_node.name}"
  policy_arn = "${format("arn:aws:iam::%s:policy/GetAnsibleGitKeySSMParameter", data.aws_caller_identity.current.account_id)}"
}

resource "aws_iam_role_policy_attachment" "autoscaling_set_instance_health" {
  role       = "${aws_iam_role.ansible_node.name}"
  policy_arn = "${format("arn:aws:iam::%s:policy/EC2AutoscalingSetInstanceHealth", data.aws_caller_identity.current.account_id)}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  count = "${var.ENABLE_AWS_MANAGEMENT_AGENTS == "true" ? 1 : 0 }"
  role = "${aws_iam_role.ansible_node.name}"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "ssm_ec2_role" {
  count = "${var.ENABLE_AWS_MANAGEMENT_AGENTS == "true" ? 1 : 0 }"
  role = "${aws_iam_role.ansible_node.name}"
  policy_arn = "${format("arn:aws:iam::%s:policy/RestrictedEC2RoleforSSM", data.aws_caller_identity.current.account_id)}"
}

output "iam_instance_profile_id" {
  value = "${aws_iam_instance_profile.ansible_node.id}"
}

output "iam_role_arn" {
  value = "${aws_iam_role.ansible_node.arn}"
}

output "iam_role_name" {
  value = "${aws_iam_role.ansible_node.name}"
}
