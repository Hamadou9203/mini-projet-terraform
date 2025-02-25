output "eip_sortie_id" {
  value = aws_eip.my_eip.id
}
output "eip_sortie_ip" {
  value = aws_eip.my_eip.public_ip
}
output "eip_sortie_dns" {
  value = aws_eip.my_eip.public_dns
}