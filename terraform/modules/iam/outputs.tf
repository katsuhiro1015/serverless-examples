output "pipeline_arn" {
  value = aws_iam_role.codepipeline.arn
}

output "build_arn" {
  value = aws_iam_role.codebuild.arn
}