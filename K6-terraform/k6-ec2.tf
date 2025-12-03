resource "aws_instance" "k6terraform" {
  instance_type               = "t3a.small" # <<<<<<<<<<<<<<<<<<<  CAMBIAR EL TAMAÑO DE INSTANCIA
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = "subnet-0b2e5f88b9158dbe3" # <<<<<<<<<<<<<<<<<<<  CAMBIAR EL SUBNET ID
  vpc_security_group_ids      = ["sg-0e0ded6b51141c3e0"]   # <<<<<<<<<<<<<<<<<<<  CAMBIAR EL SG ID
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key.key_name

  user_data = file("${path.module}/script.sh")

  tags = {
    Name = "k6-main"
  }

  provisioner "remote-exec" {
    inline = [
      "until [ -f /tmp/token ]; do sleep 5; echo 'waiting for token ...'; done",
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.key_name) # Nombre de la llave privada SSH (.pem)
    }
  }

  provisioner "local-exec" {
    command = <<EOT
			scp -o StrictHostKeyChecking=no -i ${var.key_name} -r ubuntu@${self.public_ip}:/tmp/token ./token

  	EOT
  }
}

data "local_file" "token" {
	depends_on = [ aws_instance.k6terraform ]
  filename = "token"
}

resource "aws_instance" "k6terraform-worker" {
  # depends_on                  = [data.local_file.token]
  instance_type               = "t3a.small" # <<<<<<<<<<<<<<<<<<<  CAMBIAR EL TAMAÑO DE INSTANCIA
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = "subnet-0b2e5f88b9158dbe3" # <<<<<<<<<<<<<<<<<<<  CAMBIAR EL SUBNET ID
  vpc_security_group_ids      = ["sg-0e0ded6b51141c3e0"]   # <<<<<<<<<<<<<<<<<<<  CAMBIAR EL SG ID
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_key.key_name

  user_data = templatefile("${path.module}/script-worker.sh", {
    TOKEN = data.local_file.token.content
  })
  tags = {
    Name = "k6-worker"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!!'"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.key_name)
    }
  }
}

