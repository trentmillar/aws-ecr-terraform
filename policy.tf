locals {
  readers = distinct(concat(var.readers, var.read_writers))

  writers = distinct(concat(var.writers, var.read_writers))
}

data "aws_iam_policy_document" "reader" {
  statement {
    principals {
      type        = "AWS"
      identifiers = local.readers
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability"
    ]
  }
}

data "aws_iam_policy_document" "writer" {
  statement {
    principals {
      type        = "AWS"
      identifiers = local.writers
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
  }
}
