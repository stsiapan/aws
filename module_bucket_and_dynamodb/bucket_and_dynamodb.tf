### create bucket 
resource "aws_s3_bucket" "my_back" {
  bucket = "stsiapan-tf-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}

### create Dynamodb table
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID" 
  
  attribute {
    name = "LockID"
    type = "S"
  }
}