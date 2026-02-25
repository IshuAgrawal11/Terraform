variable "aws_instance_type" {
    default = "t3.micro"
    type = string
}

variable "aws_region" {
    default = "eu-north-1"

}

variable "ami_id" {
    default = "ami-073130f74f5ffb161"
    type = string
  
}

variable "root_volume_size" {
    default = 20
    type = number
}