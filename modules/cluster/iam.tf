resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.name_project}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    var.tags,
    {
      name = "${var.name_project}-cluster-role"
    }
  )
}

resource "aws_iam_policy_attachment" "eks_cluster_role_attachment" {
  name       = "eks_cluster_role_attachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}