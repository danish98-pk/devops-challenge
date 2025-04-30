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


# to authenticate
# sudo docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 680343405290.dkr.ecr.us-east-1.amazonaws.com

#tag
# docker tag prod-app:latest 680343405290.dkr.ecr.us-east-1.amazonaws.com/crewmeister-challenge:latest

#push
# docker push 680343405290.dkr.ecr.us-east-1.amazonaws.com/crewmeister-challenge:latest