output "associated_amis" {
  value = [
    for instance in aws_instance.eip_ec2 : {
      ami  = instance.ami
      id   = instance.id
      name = instance.tags["Name"]
    }
  ]
}