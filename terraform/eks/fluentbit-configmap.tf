resource "kubernetes_config_map" "dev-eks-fluentbit" {
  metadata {
    name = local.fluentbit-role-name
    namespace = kubernetes_namespace.dev-eks-fluentbit-ns.metadata.0.name
    labels = local.labels
  }

  data = {
      "fluent-bit.conf" = <<EOF
[SERVICE]
    Flush         1
    Log_Level     info
    Log_File /var/log/fluent.log
    Daemon        off
    Parsers_File  parsers.conf
    HTTP_Server   On
    HTTP_Listen   0.0.0.0
    HTTP_Port     2020
    Parsers_File parsers.conf

[INPUT]
    Name              tail
    Tag               kube.*
    Path              /var/log/containers/*.log
    Parser            docker
    #Multiline         On
    #Multiline_Flush   5
    #Parser_Firstline  multiline
    DB                /var/log/flb_kube.db
    Mem_Buf_Limit     50MB
    Skip_Long_Lines   On
    Refresh_Interval  10

[FILTER]
    Name                kubernetes
    Match               kube.*
    Kube_URL            ${module.eks.cluster_endpoint}:443
    Kube_CA_File        /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    Kube_Token_File     /var/run/secrets/kubernetes.io/serviceaccount/token
    Kube_Tag_Prefix     kube.var.log.containers.
    Merge_Log           On
    Merge_Log_Key       log_processed
    K8S-Logging.Parser  On
    K8S-Logging.Exclude Off

[OUTPUT]
    Name            es
    Match           *
    Host            ${var.dev-eks-es-host}
    Port            ${var.dev-eks-es-port}
    TLS             On
    AWS_Region      ${var.aws_region}
    AWS_Auth        On
    Replace_Dots    On
    Retry_Limit     6
    Logstash_Prefix ${var.logstash_prefix}
    Logstash_Format True
EOF

    "parsers.conf" = <<EOF
[PARSER]
    Name        docker
    Format      json
    Time_Key    time
    Time_Format %Y-%m-%dT%H:%M:%S.%L
    Time_Keep   On
    Decode_Field_as json log

[PARSER]
    Name                multiline
    Format              regex
    Regex               ^{"log":"(?!\\u0009)(?<log>\S(?:(\\")|[^"]){9}(?:(\\")|[^"])*)"

[PARSER]
    Name        syslog
    Format      regex
    Regex       ^\<(?<pri>[0-9]+)\>(?<time>[^ ]* {1,2}[^ ]* [^ ]*) (?<host>[^ ]*) (?<ident>[a-zA-Z0-9_\/\.\-]*)(?:\[(?<pid>[0-9]+)\])?(?:[^\:]*\:)? *(?<message>.*)$
    Time_Key    time
    Time_Format %b %d %H:%M:%S
EOF
  }
  depends_on = [module.eks]
}