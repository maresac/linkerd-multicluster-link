# linkerd-multicluster-link

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm chart to support the `linkerd multicluster link` CLI command.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterLinks[0].gatewayAddress | string | `"172.18.255.100"` |  |
| clusterLinks[0].name | string | `"kind-workload"` |  |
| clusterLinks[0].secretName | string | `"cluster-credentials-kind-workload"` |  |
| linkerdVersion | string | `"stable-2.12.4"` |  |
| mirroredServiceLabel.key | string | `"mirror.linkerd.io/exported"` |  |
| mirroredServiceLabel.value | string | `"true"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)