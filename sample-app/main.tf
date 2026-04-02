# ❌ BAD: S3 bucket with public access
resource "aws_s3_bucket" "app_data" {
  bucket = "my-app-data-${random_id.bucket_suffix.hex}"
  acl    = "public-read"  # ❌ PUBLIC!

  tags = {
    Name = "app-data"
  }
}

# ❌ BAD: Security group open to world on sensitive port
resource "aws_security_group" "app" {
  name = "app-sg"

  ingress {
    from_port   = 3306  # MySQL
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ❌ OPEN TO WORLD!
  }

  tags = {
    Name = "app-sg"
  }
}

# ❌ BAD: No encryption on EBS volume
resource "aws_ebs_volume" "app_data" {
  availability_zone = "us-east-1a"
  size              = 100
  encrypted         = false  # ❌ NOT ENCRYPTED!

  tags = {
    Name = "app-data"
  }
}

# ❌ BAD: RDS database with no backup retention
resource "aws_db_instance" "app_db" {
  identifier     = "mydb"
  engine         = "mysql"
  engine_version = "5.7"  # ❌ OLD VERSION
  instance_class = "db.t2.micro"
  allocated_storage = 20
  backup_retention_period = 0  # ❌ NO BACKUPS!
  
  # ❌ BAD: Master credentials in code (would be caught by secret scan)
  username = "admin"
  password = "password123"

  skip_final_snapshot = true
}
