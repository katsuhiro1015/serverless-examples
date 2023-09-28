resource "aws_codebuild_project" "build_project01" {
  name = "build-project01"

  service_role  = aws_iam_role.codebuild_iam_role.arn

  source {
    type = "S3"
    location = "tutorial-codebuild-input/MessageUtil.zip"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type = "LINUX_CONTAINER"
  }

  artifacts {
    type = "S3"
    location = "tutorial-codebuild-output"
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/build-project01"
      stream_name = "build-log"
    }
  }
}
