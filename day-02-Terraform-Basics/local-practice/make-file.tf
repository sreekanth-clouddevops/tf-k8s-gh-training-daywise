resource "local_file" "demo-file" {
  filename        = "./demo-abhi-file.txt"
  content         = "Thia is my sample terraform local file"
  file_permission = "0700"
}