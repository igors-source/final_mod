# Создание сервисного аккаунта
resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
  description = "Сервис-аккаунт"
  folder_id = "b1gd6mkmc0olqg7vk03m" 
}

# Роль сервисного аккаунта
resource "yandex_resourcemanager_folder_iam_binding" "ig-sa-role" {
  folder_id = "b1gd6mkmc0olqg7vk03m"
  
  for_each  = toset([
    "editor",
    "storage.admin"
  ])

  role      = each.key
  members   = [
    "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
  ]
}

# Ключ
resource "yandex_iam_service_account_static_access_key" "ig-sa-key" {
  service_account_id = yandex_iam_service_account.ig-sa.id
}

# бакет
resource "yandex_storage_bucket" "diploma-tfstate-bucket-300" {
  bucket = "tfstate-backet-300"
  acl = "private"
  access_key = yandex_iam_service_account_static_access_key.ig-sa-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.ig-sa-key.secret_key

}

