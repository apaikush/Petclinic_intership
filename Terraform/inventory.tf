resource "local_file" "build-hosts" {
  content = templatefile("terraform_template.tpl",
    {
      jenkins_server_ip = module.VM1.ephermal_ip
      jenkins_agent_ip = module.VM2.ephermal_ip
      nexus_server_ip = module.VM3.ephermal_ip
      app_server_ip = module.VM4.ephermal_ip


      jenkins_key = "${path.module}/keys/jenkins_private"
      nexus_key = "${path.module}/keys/jenkins_private"
    }
  )
  filename = "${path.module}/../Ansible/terr_inventory"
}