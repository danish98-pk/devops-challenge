locals {
  env         = "staging"
  region      = "us-east-1"
  zone1       = "us-east-1a"
  zone2       = "us-east-1b"
  eks_name    = "demo"
  eks_version = "1.30"
  

  db_config = {
    username = "root"              
    password = "crewmeister123"
    db_name  = "challenge"
    port     = 3306
  }


}