resource "monitor" "blog1-staging-connections" {

    count = var.nunmber_of_dbs
    name = "blog1-staging-connections-${count.index}"

    metric = "Connections"
    target = aws_db_instance.blog1-staging.id

    // frequency in secs
    frequency = 60
    critical = var.alarm_trigger_critical

    warning = var.alarm_trigger_warning

    alarm_channel = "alarm SNS topic"
    ok_channel = "ok SNS topic"
}

resource "monitor" "blog1-staging-cpu" {

    count = var.nunmber_of_dbs
    name = "blog1-staging-cpu-${count.index}"

    metric = "CPUUtilization"
    target = aws_db_instance.blog1-staging.id

    // frequency in secs
    frequency = 60
    critical = var.alarm_trigger_critical

    warning = var.alarm_trigger_warning

    alarm_channel = "alarm SNS topic"
    ok_channel = "ok SNS topic"
}

