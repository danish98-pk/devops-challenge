output "ecr_repo" {
  description = "ecr repository arn"
  value       = aws_ecr_repository.crewmeister.arn
}