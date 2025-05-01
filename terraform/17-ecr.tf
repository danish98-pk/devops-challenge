resource "aws_ecr_repository" "crewmeister" {
  name                 = "crewmeister-challenge"
  force_delete = true
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "untagged" {
  repository = aws_ecr_repository.crewmeister.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images as soon as possible"
        selection = {
          tagStatus     = "untagged"
          countType     = "sinceImagePushed"
          countUnit     = "days"
          countNumber   = 1
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
