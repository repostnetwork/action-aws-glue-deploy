locals {
  glue_script_key = "admin/${var.glue_job_name}.py"
}

resource "aws_s3_bucket_object" "glue_script" {
  bucket = "${var.glue_script_bucket}"
  key    = "${local.glue_script_key}"
  source = "/github/workspace/${var.glue_script_local_path}"
}

resource "aws_glue_job" "glue_job" {
  name     = "${var.glue_job_name}"
  role_arn = "${var.glue_job_role_arn}"

  command {
    script_location = "s3://${var.glue_script_bucket}/${local.glue_script_key}"
  }

  glue_version = "2.0"
}

resource "aws_glue_trigger" "glue_trigger" {
  name     = "${var.glue_job_name}_daily"
  schedule = "cron(0 0 * * ? *)"
  type     = "SCHEDULED"

  actions {
    job_name = "${aws_glue_job.glue_job.name}"
  }
}
