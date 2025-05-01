#set ecr repository
resource "aws_ecr_repository" "crewmeister" {
  name                 = var.ecr_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }
}


#ecr lifecycle for terminating untagged images after a day
resource "aws_ecr_lifecycle_policy" "untagged" {
  repository = aws_ecr_repository.crewmeister.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images as soon as possible"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 1
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
