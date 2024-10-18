resource "aws_iam_role" "eks_controller_role" {
  name = "${var.name_project}-aws-load-balancer-controller"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}:aud": "sts.amazonaws.com",
                    "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        }
    ]
}
EOF

  tags = merge(
    var.tags,
    {
      name = "${var.name_project}-aws-load-balancer-controller"
    }
  )
}

resource "aws_iam_policy_attachment" "eks_controller_role_attachment" {
  name       = "eks_cluster_role_attachment"
  roles      = [aws_iam_role.eks_controller_role.name]
  policy_arn = aws_iam_policy.eks_controller_policy.arn
}