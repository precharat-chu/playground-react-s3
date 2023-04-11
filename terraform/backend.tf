terraform {
  backend "remote" {
    organization = "precharat-chu"
    workspaces {
      name = "playground-react-s3"
    }
  }
}
