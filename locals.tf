locals {
  subnet_name_develop_a = "${var.vpc_name}-${var.zone_prefix_a}"
  subnet_name_develop_b = "${var.vpc_name}-${var.zone_prefix_b}"
  vm_web_name = "${var.vms_config[0].org_name}-${var.vms_config[0].env}-${var.vms_config[0].base}-${var.vms_config[0].role}"
  vm_db_name = "${var.vms_config[1].org_name}-${var.vms_config[1].env}-${var.vms_config[1].base}-${var.vms_config[1].role}"
}