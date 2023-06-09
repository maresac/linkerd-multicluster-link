## Linkerd multicluster link Helm chart

This chart contains resources based on the `linkerd multicluster link` command. It offers the possibility to link multiple target clusters to a single source cluster. This way, services in the source cluster will be able to access services in the target clusters with the help of [service mirroring](https://linkerd.io/2020/02/25/multicluster-kubernetes-with-service-mirroring/).

The chart is meant to be deployed in the source cluster, i.e. the cluster from which you want to be able to access services from the target clusters.

For each target link, the following values can be provided:

* `name` of the cluster, which should identify it among all other clusters.
* `gatewayAddress`: External IP of the target cluster's multicluster gateway service. If your Linkerd multicluster control plane is installed in the
`linkerd-multicluster` namespace, you can find it here:
  ```
  kubectl -n linkerd-multicluster get svc linkerd-gateway -ojsonpath='{.status.loadBalancer.ingress[0].ip}'
  ```
* `gatewayIdentity`: Server identity of the target multicluster gateway. Defaults to `linkerd-gateway.linkerd-multicluster.serviceaccount.identity.linkerd.cluster.local`.
* `secretName`: Name of the secret containing the target cluster's kubeconfig.
* `linkAnnotations`: Annotations for the `Link` resource.
* `serviceAccountAnnotations`: Annotations for the `Service Mirror`'s `ServiceAccount`. This is useful for example if you need to use Workload Identity to be able to access a GKE Autopilot target cluster (see [here](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity)).
* `targetClusterDomain`: Domain of the target cluster. Defaults to `cluster.local`.
* `targetClusterLinkerdNamespace`: Namespace of the Linkerd installation in the target cluster. Defaults to `linkerd`.

Since the Linkerd Service Mirror in the source cluster needs access to the target clusters' k8s API, it needs kubeconfigs for the target clusters.
These have to be provided through `Secret` resources before deploying this chart.
The kubeconfigs can be copied from the output of the `linkerd multicluster link` command.

Here's an example on how to manually create a kubeconfig Secret for a `<target>` cluster:
```
export TARGET=<target>
export SOURCE=<source>
linkerd --context $TARGET multicluster link --cluster-name $TARGET | \
  yq ea 'select(.kind == "Secret") | .data.kubeconfig' | \
  base64 -d | \
  kubectl create secret generic cluster-credentials-$TARGET \
  --context $SOURCE -n linkerd-multicluster \
  --type "mirror.linkerd.io/remote-kubeconfig" --from-file=kubeconfig=/dev/stdin
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterLinks | list | `[]` |  |
| linkerdVersion | string | `"stable-2.12.4"` |  |
| mirroredServiceLabel.key | string | `"mirror.linkerd.io/exported"` |  |
| mirroredServiceLabel.value | string | `"true"` |  |
