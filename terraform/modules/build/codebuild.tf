resource "aws_codebuild_project" "build_application" {
  name = "${var.pjname}"

  service_role  = var.aws_iam_role_build_arn

  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:7.0"
    type = "LINUX_CONTAINER"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${var.pjname}"
      stream_name = "build-log"
    }
  }
}
