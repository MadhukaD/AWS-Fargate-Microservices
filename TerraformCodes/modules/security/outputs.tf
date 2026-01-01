output "security_group_id" {
  value = aws_security_group.test_server_sg.id
}

output "key_name" {
  value = aws_key_pair.generated_key.key_name
}

output "private_key_path" {
  value = local_file.private_pem.filename
}
