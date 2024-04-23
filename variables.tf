variable "config" {
  description = "Configuration for the EC2 instance, including image ID and instance type."
  default = {
    image_id = "ami-080e1f13689e07408"

  }
}

variable "list" {
  type    = list(string)
  default = ["t2.medium", "t2.large", "t2.micro", "t2.nano"]

}

variable "vm_types" {
  type    = list(string)
  default = ["atp-dev", "atp-qa", "atp-uat", "atp-prod"]
}

variable "ami" {
  type    = list(string)
  default = ["ami-080e1f13689e07408", "ami-04e5276ebb8451442", "ami-058bd2d568351da34", "ami-0fe630eb857a6ec83"]

}