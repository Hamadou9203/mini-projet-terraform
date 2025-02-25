output "key_sortie_name" {
  value = aws_key_pair.my_key.key_name
}

output "key_sortie_private" {

   value = tls_private_key.rsa-4096.private_key_pem  
   sensitive = true # sensitive content
}