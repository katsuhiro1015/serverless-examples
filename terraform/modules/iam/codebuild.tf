resource "aws_iam_role" "codebuild_iam_role" {
  name = "CodeBuildServiceRole"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json
}

# IAM Policy Document

data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

# IAM Policy

resource "aws_iam_policy" "codebuild_base_policy" {
  name = "CodeBuildBasePolicy"
  policy = file("./codebuild_policy.json")
}

resource "aws_iam_policy" "codebuild_ro_policy" {
  name = "CodeBuildReadOnlyPolicy"
  policy = file("./codebuild_ro_policy.json")
}

# Policy Attachment

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment01" {
  role = aws_iam_role.codebuild_iam_role.name
  policy_arn = aws_iam_policy.codebuild_base_policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment02" {
  role = aws_iam_role.codebuild_iam_role.name
  policy_arn = aws_iam_policy.codebuild_ro_policy.arn
}
