resource "tls_private_key" "jenkins_key" {
 algorithm = "ED25519"
}

#resource "tls_private_key" "nexus_key" {
# algorithm = "ED25519"
#}

data "tls_public_key" "jenkins_public_key" {
  private_key_pem = tls_private_key.jenkins_key.private_key_pem
}

resource "local_file" "jenkins_private_key" {
  content         = tls_private_key.jenkins_key.private_key_openssh
  filename        = "${path.module}/keys/jenkins_private"
  file_permission = "600"
}

resource "local_file" "jenkins_public_key" {
  content  = data.tls_public_key.jenkins_public_key.public_key_openssh
  filename = "${path.module}/keys/jenkins_public.pub"
  file_permission = "600"
}  
#resource "local_file" "nexus_private_key" {
#  content         = tls_private_key.nexus_key.private_key_openssh
#  filename        = var.nexus_key_path
#  file_permission = "600"
#}