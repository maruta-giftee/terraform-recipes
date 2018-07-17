variable "common" {
  type = "map"

  default = {
    default.region  = "ap-northeast-1"
    default.project = "terraform-recipes"
  }
}

variable "vpc" {
  type = "map"

  default = {
    default.cidr      = "10.0.0.0/16"
    stg.cidr          = "10.1.0.0/16"
    dev.cidr          = "10.2.0.0/16"
    qa.cidr           = "10.3.0.0/16"
    default.public_1a = "10.0.1.0/26"
    default.public_1c = "10.0.1.64/26"
    default.public_1d = "10.0.1.128/26"
    stg.public_1a     = "10.1.1.0/26"
    stg.public_1c     = "10.1.1.64/26"
    stg.public_1d     = "10.1.1.128/26"
    dev.public_1a     = "10.2.1.0/26"
    dev.public_1c     = "10.2.1.64/26"
    dev.public_1d     = "10.2.1.128/26"
    qa.public_1a      = "10.3.1.0/26"
    qa.public_1c      = "10.3.1.64/26"
    qa.public_1d      = "10.3.1.128/26"
  }
}
