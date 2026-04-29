variable "name" {
  type = string
}

resource "aws_ecr_repository" "repo" {
  name = var.name

  lifecycle {
    prevent_destroy = true
  }
}

output "repository_url" {
  value = aws_ecr_repository.repo.repository_url
}
