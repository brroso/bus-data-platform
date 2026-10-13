resource "aws_organizations_policy" "allowed_regions" {
  name        = "allowed-regions"
  description = "Nega operacoes fora de sa-east-1 e us-east-1"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "DenyOutsideAllowedRegions"
      Effect = "Deny"
      NotAction = [
        "account:*",
        "budgets:*",
        "ce:*",
        "cloudfront:*",
        "cur:*",
        "ec2:DescribeRegions",
        "globalaccelerator:*",
        "health:*",
        "iam:*",
        "organizations:*",
        "pricing:*",
        "route53:*",
        "route53domains:*",
        "s3:GetBucketLocation",
        "s3:ListAllMyBuckets",
        "shield:*",
        "sts:*",
        "support:*",
        "trustedadvisor:*",
        "waf:*",
        "wafv2:*",
      ]
      Resource = "*"
      Condition = {
        StringNotEquals = {
          "aws:RequestedRegion" = ["sa-east-1", "us-east-1"]
        }
      }
    }]
  })
}

resource "aws_organizations_policy" "baseline" {
  name        = "baseline-guardrails"
  description = "Nega root nas contas-membro e saida da organizacao"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DenyRootUser"
        Effect   = "Deny"
        Action   = "*"
        Resource = "*"
        Condition = {
          StringLike = { "aws:PrincipalArn" = ["arn:aws:iam::*:root"] }
        }
      },
      {
        Sid      = "DenyLeaveOrganization"
        Effect   = "Deny"
        Action   = "organizations:LeaveOrganization"
        Resource = "*"
      },
    ]
  })
}

resource "aws_organizations_policy_attachment" "allowed_regions" {
  policy_id = aws_organizations_policy.allowed_regions.id
  target_id = aws_organizations_organizational_unit.workloads.id
}

resource "aws_organizations_policy_attachment" "baseline" {
  policy_id = aws_organizations_policy.baseline.id
  target_id = aws_organizations_organizational_unit.workloads.id
}