variable "nunmber_of_dbs" {
  description = "Number of Databases"
  type        = number
  default     = 20
}

variable "environment" {
  description = "Environments to deploy to"
  type        = list(string)
  default     = [
    "development",
    "qa",
    "staging",
    "production",
  ]
}

variable "alarm_trigger_critical" {
  type = list(object({
    operator = string
    threshold = number
    evaluation_periods = number
  }))
  default = [
    {
        operator = ">="
        threshold = 85
        evaluation_periods = 5
    }
  ]
}

variable "alarm_trigger_warning" {
  type = list(object({
    operator = string
    threshold = number
    evaluation_periods = number
  }))
  default = [
    {
        operator = ">="
        threshold = 60
        evaluation_periods = 5
    }
  ]
}