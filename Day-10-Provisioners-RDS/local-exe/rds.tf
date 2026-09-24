provider "aws" {
  region = "us-east-1"
}

# Create the RDS MySQL instance
resource "aws_db_instance" "mysql_rds" {
  identifier          = "my-mysql-db"
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20

  username            = "admin"
  password            = "Password123!"
  db_name             = "dev"

  publicly_accessible = true
  skip_final_snapshot = true
}

# Execute SQL script from local machine
resource "null_resource" "local_sql_exec" {

  # Wait until RDS is created
  depends_on = [aws_db_instance.mysql_rds]

  provisioner "local-exec" {

    # Use Git Bash
    interpreter = [
      "C:/Program Files/Git/bin/bash.exe",
      "-c"
    ]

    # Execute init.sql against RDS
    command = "\"/c/Program Files/MySQL/MySQL Server 8.4/bin/mysql.exe\" -h ${aws_db_instance.mysql_rds.address} -u admin -pPassword123! dev < init.sql"
  }

  # Run provisioner every time terraform apply is executed
  triggers = {
    always_run = timestamp()
  }
}