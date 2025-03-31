###Network variables

variable "zone_prefix_a" {
  type = string
  default = "a"
}

variable "zone_prefix_b" {
  type = string
  default = "b"
}

variable "default_cidr_a" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###vms vars for web

variable "vm_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Family and version for OS"
}

# variable "vm_web_name" {
#   type        = string
#   default     = "netology-develop-platform-web"
#   description = "Name for VM"
# }

# variable "vm_web_platform" {
#   type = string
#   default = "standard-v3"
#   description = "Type of CPU"
# }

# variable "vm_web_core" {
#   type = number
#   default = 2
#   description = "Number of cores"
# }

# variable "vm_web_memory" {
#   type = number
#   default = 1
#   description = "Number of memory"
# }

# variable "vm_web_fraction" {
#   type = number
#   default = 20
#   description = "Number of used CPU in %"
# }

# ###vms vars for db

# variable "vm_db_image_name" {
#   type        = string
#   default     = "ubuntu-2004-lts"
#   description = "Family and version for OS"
# }

# variable "vm_db_name" {
#   type        = string
#   default     = "netology-develop-platform-db"
#   description = "Name for VM"
# }

# variable "vm_db_platform" {
#   type = string
#   default = "standard-v3"
#   description = "Type of CPU"
# }

# variable "vm_db_core" {
#   type = number
#   default = 2
#   description = "Number of cores"
# }

# variable "vm_db_memory" {
#   type = number
#   default = 2
#   description = "Number of memory"
# }

# variable "vm_db_fraction" {
#   type = number
#   default = 20
#   description = "Number of used CPU in %"
# }

variable "vms_config" {
  type = list(object({
    org_name      = string
    env           = string
    base          = string
    role          = string
    platform_id   = string
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
  default = [
    {
      org_name      = "netology"
      env           = "develop"
      base          = "platform"
      role          = "web"
      platform_id   = "standard-v3"
      cores         = 2
      memory        = 1
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-hdd"
    },
    {
      org_name      = "netology"
      env           = "develop"
      base          = "platform"
      role          = "db"
      platform_id   = "standard-v3"
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-ssd"
    }
  ]
}