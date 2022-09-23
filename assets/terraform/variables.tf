variable "PROJECT_ID" {
  type = string
}

variable "REGION" {
  type = string
}

variable "NETWORK" {
  type = map(string)
}

variable "GKE" {
  type = map(string)
}
