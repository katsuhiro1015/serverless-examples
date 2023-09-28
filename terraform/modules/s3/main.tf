resource "aws_s3_bucket" "artifact" {
  bucket = "${pjname}-codepipeline-github-artifact"
}
