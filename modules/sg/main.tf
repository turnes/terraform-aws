resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags
  )
}

resource "aws_security_group_rule" "cidr_blocks" {
  count             = length(var.rule_cidr_blocks) != 0 ? length(var.rule_cidr_blocks) : 0
  security_group_id = aws_security_group.this.id

  type        = lookup(element(var.rule_cidr_blocks, count.index).value, "type", null)
  description = lookup(element(var.rule_cidr_blocks, count.index).value, "description", null)
  from_port   = lookup(element(var.rule_cidr_blocks, count.index).value, "from_port", null)
  to_port     = lookup(element(var.rule_cidr_blocks, count.index).value, "to_port", null)
  protocol    = lookup(element(var.rule_cidr_blocks, count.index).value, "protocol", null)
  cidr_blocks = lookup(element(var.rule_cidr_blocks, count.index).value, "cidr_blocks", null)
}


# resource "aws_security_group_rule" "security_group_id" {
#   count             = length(var.ingress_security_group_id) > 0 ? length(var.ingress_security_group_id) : 0 
#   security_group_id = aws_security_group.this.id

#   type            = ingress_security_group_id[count.index]["type"]
#   description     = ingress_security_group_id[count.index]["description"]
#   to_port         = ingress_security_group_id[count.index]["to_port"]
#   protocol        = ingress_security_group_id[count.index]["protocol"]
#   security_groups = ingress_security_group_id[count.index]["security_groups"]
# }

