module "codepipeline_role" {
  source = "../modules/aws/iam/iam_role"

  role_name = "CodePipelineServiceRole"
  role_description = "service role for codepipeline."

  trusted_role_services = [
    "codepipeline.amazonaws.com"
  ]

  policy_names = [
    "CodePipelineBasePolicy",
  ]

  policy_json_files = [
    "./codepipeline_policy.json"
  ]
}
