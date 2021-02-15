locals {
  readers     = var.readers //distinct(concat(var.readers, var.reader_writers))
  writers     = var.writers //distinct(concat(var.writers, var.reader_writers))
  full_access = var.reader_writers
}

data "aws_iam_policy_document" "reader_writer" {
  statement {
    principals {
      type        = "AWS"
      identifiers = local.full_access
    }

    actions = [
      /* reader */
      "ecr:BatchGetImage",
      /* writer */
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
  }
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
