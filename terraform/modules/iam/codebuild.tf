resource "aws_iam_role" "codebuild" {
  name = "ServerlessBuildServiceRole"
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

data "template_file" "codebuild_base_policy" {
  template = file("../../modules/iam/json/codebuild_policy.json")
  vars = {
    pjname = var.pjname
    region = var.region
    account = "${data.aws_caller_identity.self.account_id}"
  }
}

data "template_file" "codebuild_ro_policy" {
  template = file("../../modules/iam/json/codebuild_ro_policy.json")
  vars = {
    pjname = var.pjname
  }
}

# IAM Policy
resource "aws_iam_policy" "codebuild_base_policy" {
  name = "CodeBuildBasePolicy"
  policy = data.template_file.codebuild_base_policy.rendered
}

resource "aws_iam_policy" "codebuild_ro_policy" {
  name = "CodeBuildReadOnlyPolicy"
  policy = data.template_file.codebuild_ro_policy.rendered
}

# Policy Attachment

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment_base" {
  role = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_base_policy.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment_ro" {
  role = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild_ro_policy.arn
}
