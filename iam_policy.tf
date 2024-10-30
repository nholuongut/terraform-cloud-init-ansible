resource "aws_iam_policy" "get_ssm_parameter" {
  name = "GetAnsibleGitKeySSMParameter"
  count = "${var.STORE_ANSIBLE_GIT_KEY == "true" ? 1 : 0 }"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [ "ssm:GetParameter" ],
      "Resource": [ "*" ]
    }
  ]
}
EOF
}

resource "aws_iam_policy" "autoscaling_set_instance_health" {
  name = "EC2AutoscalingSetInstanceHealth"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [ "autoscaling:SetInstanceHealth" ],
      "Resource": [ "*" ]
    }
  ]
}
EOF
}

# Amazon's "AmazonEC2RoleforSSM" manged IAM role is too loose.
# https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent-minimum-s3-permissions.html
# This should only be enabled once.
resource "aws_iam_policy" "restricted_ec2_role_for_ssm" {
  name = "RestrictedEC2RoleforSSM"
  count = "${var.CREATE_AWS_MANAGEMENT_POLICY == "true" ? 1 : 0 }"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstanceStatus"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ds:CreateComputer",
                "ds:DescribeDirectories"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:GetObject",
            "Resource": [
                "arn:aws:s3:::aws-ssm-*/*",
                "arn:aws:s3:::aws-windows-downloads-*/*",
                "arn:aws:s3:::amazon-ssm-packages-*/*",
                "arn:aws:s3:::*-birdwatcher-*/*"
            ]
        }
    ]
}
EOF
}
