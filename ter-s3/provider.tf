terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.3"
}

provider "yandex" {
  token     = var.yandex_cloud_token 
  cloud_id  = "b1gi9apmglo1h670hla4"
  folder_id = "b1gd6mkmc0olqg7vk03m"
  zone      = "ru-central1-a"
}