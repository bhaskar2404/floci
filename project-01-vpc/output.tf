output "vpc_id" {
  description = "Id of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block for VPC"
  value       = aws_vpc.main.cidr_block

}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id

}

output "internet_gateway_id" {

  value = aws_internet_gateway.igw.id

}
output "public_route_table" {
  value = aws_route_table.public.id
}

output "private_route_table" {
  value = aws_route_table.private.id
}

output "nate_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "nat_epi" {
  value = aws_eip.nat_eip.id
}

output "public_security_group_id" {
  value = aws_security_group.public_sg.id
}

output "private_security_group_id" {
  value = aws_security_group.private_sg.id

}
output "s3_vpc_endpoint" {
  value = aws_vpc_endpoint.s3.id
}