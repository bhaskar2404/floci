output "existing_vpc_id" {
  value = data.aws_vpc.existing.id
}
output "existing_vpc_cidr" {
  value = data.aws_vpc.existing.cidr_block
}

output "existing_vpc_name" {
  value = data.aws_vpc.existing.tags["Name"]
}