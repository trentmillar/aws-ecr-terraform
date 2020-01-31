provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "this" {
  name = var.repository_name
}

resource "aws_ecr_repository_policy" "readers" {
  count = length(local.readers) > 0 ? 1 : 0

  repository = aws_ecr_repository.default.name
  policy     = data.aws_iam_policy_document.reader.json
}

resource "aws_ecr_repository_policy" "writers" {
  count = length(local.writers) > 0 ? 1 : 0

  repository = aws_ecr_repository.default.name
  policy     = data.aws_iam_policy_document.writer.json
}

resource "aws_ecr_lifecycle_policy" "default" {
  repository = aws_ecr_repository.default.name
  policy     = file(./lifecycle.json)
}