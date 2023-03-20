  resource "aws_db_instance" "teamf-db" {
  allocated_storage = 8
  skip_final_snapshot = true
  engine = "mysql"
  engine_version = "8.0.28"
  instance_class = "db.t3.micro"
  db_name = "teamf-db"
  username = "fivebirds"
  password = "fivebirds"
  vpc_security_group_ids = [aws_security_group.rds-ecs.id]
  db_subnet_group_name = aws_db_subnet_group.rds.name
  tags = {Name = "teamf-db"}
  }