locals {
  target_port = [for key, value in var.forwarding_config : value.dest_port]
  dest_to_src = zipmap([for key, value in var.forwarding_config : value.dest_port], [for key, value in var.forwarding_config : key])
}

resource "aws_lb" "lb" {
  name               = "${var.namespace}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnet_ids
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  for_each          = var.forwarding_config
  port              = each.key
  protocol          = each.value.protocol
  default_action {
    target_group_arn = aws_lb_target_group.tg[each.key].arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "tg" {
  for_each    = var.forwarding_config
  name        = "${var.namespace}-tg-${each.key}-${each.value.dest_port}"
  port        = each.value.dest_port
  protocol    = each.value.protocol
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    interval            = 30
    port                = each.value.dest_port
    protocol            = "TCP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "tga" {
  for_each = {
    for pair in setproduct(local.target_port, range(var.instance_count)) : "${pair[0]} ${pair[1]}" => {
      dest_port = pair[0]
      idx       = pair[1]
    }
  }

  target_group_arn = aws_lb_target_group.tg[local.dest_to_src[each.value.dest_port]].arn
  port             = each.value.dest_port
  target_id        = var.instance_ids[each.value.idx]
}
