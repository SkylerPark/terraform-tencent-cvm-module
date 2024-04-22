module "ssh_key" {
  source             = "../../modules/key-pair"
  name               = "parksmKey"
  create_private_key = true
}
