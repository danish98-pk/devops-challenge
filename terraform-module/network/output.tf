output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}


output "private_zone_1" {
  description = "IDs of the private zone 1"
  value       = aws_subnet.private_zone1.id

}

output "private_zone_2" {
  description = "IDs of the private zone 2"
  value       = aws_subnet.private_zone2.id
}

output "public_zone_1" {
  description = "IDs of the public zone 2"
  value       = aws_subnet.public_zone1.id
}

output "public_zone_2" {
  description = "IDs of the public zone 2"
  value       = aws_subnet.public_zone2.id
}