resource "aws_security_group" "sg-lb" {
  name        = "ALBSecurityGroup"
  vpc_id      = data.aws_vpc.selected.id
  tags = {
    Name = "TF+ALBSecurityGroup"
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "server-sg" {
  name        = "LTSecurityGroup"
  vpc_id      = data.aws_vpc.selected.id
  tags = {
    Name = "TF+LTSecurityGroup"
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [ aws_security_group.sg-lb.id ]
  }
ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db-sg" {
  name        = "DBSecurityGroup"
  vpc_id      = data.aws_vpc.selected.id
  tags = {
    Name = "TF+DBSecurityGroup"
  }
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [ aws_security_group.server-sg.id ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}