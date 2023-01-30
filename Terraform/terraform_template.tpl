[jenkins_server]
jenkins-server ansible_ssh_host=${jenkins_server_ip} ansible_ssh_private_key_file=${jenkins_key}

[jenkins_agent]
jenkins-agent ansible_ssh_host=${jenkins_agent_ip} ansible_ssh_private_key_file=${jenkins_key}

[nexus_server]
nexus-server ansible_ssh_host=${nexus_server_ip} ansible_ssh_private_key_file=${nexus_key}

[app_server]
app-server ansible_ssh_host=${app_server_ip} ansible_ssh_private_key_file=${nexus_key}