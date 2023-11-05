output "vpc_id" {
  description = "ID of the vpc"
  value       = aws_vpc.Kyrylo_Dobrosol_01_vpc.id
}

output "security_group_id_ssh" {
  description = "ID of the security group ssh"
  value       = aws_security_group.ssh-inbound.id
}

output "security_group_id_http" {
  description = "ID of the security group http"
  value       = aws_security_group.http-inbound.id
}

output "security_group_id_http_lb" {
  description = "ID of the security group lb"
  value       = aws_security_group.lb-http-inbound.id
}

output "iam_instance_profile_name" {
  description = "Name of the instance profile"
  value       = aws_iam_instance_profile.Kyrylo_Dobrosol_01_instance_profile.name
}

output "s3_bucket_name" {
  description = "Name of the s3 bucket"
  value       = aws_s3_bucket.Kyrylo_Dobrosol_01_bucket.bucket
}

output "public_subnet_ids" {
  description = "IDs of the public subntes"
  value       = [aws_subnet.Kyrylo_Dobrosol_01_subnet_public_a.id,aws_subnet.Kyrylo_Dobrosol_01_subnet_public_b.id,aws_subnet.Kyrylo_Dobrosol_01_subnet_public_c.id]
}