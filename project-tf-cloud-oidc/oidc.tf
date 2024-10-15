import {
  to = aws_iam_openid_connect_provider.terraform_cloud
  id = "arn:aws:iam::058264144724:oidc-provider/app.terraform.io"
}

data "tls_certificate" "terraform_cloud" {
  url = "https://${var.terraform_cloud_hostname}"
}

resource "aws_iam_openid_connect_provider" "terraform_cloud" {
  url             = data.tls_certificate.terraform_cloud.url
  client_id_list  = [var.terraform_cloud_audience]
  thumbprint_list = [data.tls_certificate.terraform_cloud.certificates[0].sha1_fingerprint]
}
