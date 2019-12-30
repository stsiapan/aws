variable "region" {
  default = "us-east-1"
}
provider "aws" {
  region = var.region
}



terraform {
  backend "s3" {
    bucket         = "stsiapan-tf-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"   
    
    dynamodb_table = "terraform-up-and-running-locks"
  }
}

# ### module creates bucket and DynamoDB for global ".tfstate" lock file and needs with first init only
# module "module_bucket_and_dynamodb" {
#   source = "./module_bucket_and_dynamodb"
# }

### module includes all existed .tf files
module "modules" {
  source = "./modules"
}


