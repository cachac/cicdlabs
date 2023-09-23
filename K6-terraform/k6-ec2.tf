resource "aws_instance" "k6terraform" {
  instance_type = "t3a.nano"
  ami = data.aws_ami.ubuntu.id
  subnet_id = "	subnet-03c4310df94378ae5"
  vpc_security_group_ids = ["sg-092125b4dbf9fd691"]
  associate_public_ip_address = true
  key_name   = aws_key_pair.ec2_key.key_name

  user_data = file("${path.module}/script.sh")

  tags = {
    Name = "k6-demo"
  }


}