resource "aws_iam_role" "test" {
  name = "eks-cluster-test"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "test-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.test.name
}

resource "aws_iam_role_policy_attachment" "test-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.test.name
}

resource "aws_eks_cluster" "test" {
  name     = "test"
  role_arn = aws_iam_role.test.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_eu_central_1a.id,
      aws_subnet.private_eu_central_1b.id,
      aws_subnet.public_eu_central_1a.id,
      aws_subnet.public_eu_central_1b.id
    ]
  }

  depends_on = [
  aws_iam_role_policy_attachment.test-AmazonEKSClusterPolicy,
  aws_iam_role_policy_attachment.test-AmazonEKSVPCResourceController
  ]
}
