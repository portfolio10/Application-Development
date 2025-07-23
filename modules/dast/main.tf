resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.shared_key_name
  iam_instance_profile        = aws_iam_instance_profile.dast.name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "DAST-ZAP"
    Role = "dast"
  }
}