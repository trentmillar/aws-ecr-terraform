provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "this" {
  name = var.repository_name
}

resource "aws_ecr_repository_policy" "readers" {
  count = length(local.readers) > 0 ? 1 : 0

  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.reader.json
}

resource "aws_ecr_repository_policy" "writers" {
  count = length(local.writers) > 0 ? 1 : 0

  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.writer.json
}

resource "aws_ecr_repository_policy" "reader_writers" {
  count = length(local.full_access) > 0 ? 1 : 0

  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.reader_writer.json
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = file("./lifecycle.json")
}

/* begin test */

resource "null_resource" "test" {
  triggers = {
    aws_ecr_repository = 10
  }

  provisioner "local-exec" {
    command = <<EOF
      $(aws ecr get-login --region ${var.region} --no-include-email) && \
      docker build -t nutrien-cli ./docker-demo && \
      docker tag nutrien-cli:latest ${aws_ecr_repository.this.repository_url}:latest && \
      docker push ${aws_ecr_repository.this.repository_url}:latest
    EOF
  }

  depends_on = [
    "aws_ecr_repository.this"
  ]
}

/* end test */

locals {
  output = {
    aws_ecr_repository_url = aws_ecr_repository.this.repository_url
  }
}
