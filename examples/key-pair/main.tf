module "ssh_key" {
  source             = "../../modules/key-pair"
  name               = "parksm-test"
  create_private_key = true
}
