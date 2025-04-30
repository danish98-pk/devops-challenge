# Fetch the AWS Account ID
# Create an OIDC provider for GitHub Actions
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"  # Audience that GitHub Actions can use to authenticate
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"  # GitHub's root CA thumbprint
  ]
}

# Create an IAM Role that GitHub Actions can assume
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-deploy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",  # Policy version
    Statement = [
      {
        Effect = "Allow",  # Allow this action
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn  # OIDC provider for GitHub Actions
        },
        Action = "sts:AssumeRoleWithWebIdentity",  # Action to assume the role
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:sub" = "repo:danish98-pk/devops:ref:refs/heads/main"  # GitHub repository and branch
          }
        }
      }
    ]
  })
}

# Alternatively, you can create a custom policy for more restricted access to ECR
resource "aws_iam_policy" "custom_ecr_push_policy" {
  name = "ECRPushPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:BatchGetImage",
          "ecr:BatchDeleteImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the custom ECR push policy to the IAM role
resource "aws_iam_role_policy_attachment" "github_actions_custom_ecr_policy" {
  role       = aws_iam_role.github_actions_role.name

  #for testing
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
