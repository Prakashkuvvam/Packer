data "aws_ami" "myami" {
  owners      = ["891377120674"]
  most_recent = true
  name_regex  = "^Prakash"
}

resource "aws_instance" "myec2" {
  ami                         = data.aws_ami.myami.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "simplekp"
  vpc_security_group_ids      = [aws_security_group.mysg.id]
  subnet_id                   = aws_subnet.mysub.id

  tags = {
    Name = "My EC2"
  }
}