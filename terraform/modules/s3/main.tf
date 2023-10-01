resource "aws_s3_bucket" "artifact" {
  bucket = "${var.pjname}-codepipeline-github-artifact"
}
