resource "aws_iam_role" "codepipeline" {
  name               = "ServerlessPipelineServiceRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

data "template_file" "codepipeline_policy" {
  template = file("../../modules/iam/json/codepipeline_policy.json")
  # vars = {
  #   pjname = var.pjname
  # }
}

resource "aws_iam_policy" "codepipeline" {
  name = "CodePipelineBasePolicy"
  policy = data.template_file.codepipeline_policy.rendered
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attachment" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = aws_iam_policy.codepipeline.arn
}
