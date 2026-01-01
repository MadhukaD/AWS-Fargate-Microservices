resource "aws_instance" "test_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = var.delete_on_termination
  }

  user_data = file("${path.module}/../scripts/install_docker_grafana_prom.sh")

  tags = {
    Name        = var.name_prefix
    Environment = "dev"
    Owner       = var.name_prefix
  }
}