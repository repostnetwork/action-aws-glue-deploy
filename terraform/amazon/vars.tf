variable "region" {
  default = "us-east-1"
}

variable "env" {
  description = "Either 'staging' or 'production'"
}

variable "glue_script_bucket" {
  description = "The bucket where the Glue job's script will be stored"
}

variable "glue_script_local_path" {
  description = "The local path to the Glue job's script"
}

variable "glue_job_name" {
  description = "The name of the Glue job"
}

variable "glue_job_role_arn" {
  description = "ARN of the IAM role that should run the Glue job"
}

provider "aws" {
  version = ">= 1.47.0"
  profile = "default"
  region = var.region
}