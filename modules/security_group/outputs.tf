output "sg_id" {
  description = "The IDs of the security groups."
  value       = aws_security_group.sg.id
}