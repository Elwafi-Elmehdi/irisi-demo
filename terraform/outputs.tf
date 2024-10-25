output "irisi_server_public_ip" {
  value = aws_instance.my_instance.public_ip
}