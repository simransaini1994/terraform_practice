variable "AWS_ACCESS_KEY" { 
}

variable "AWS_SECRET_KEY" {
  
}

variable "AWS_REGION" {
    
  default = "us-east-2"
}       

variable "AMIS" {
  
  type =  map
  default = {
      us-east-2 = "ami-08962a4068733a2b6"
  }
}


variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}
