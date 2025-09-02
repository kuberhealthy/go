# Example Go Client

This repository contains a minimal Go example program under `cmd/example` that reports its status back to [Kuberhealthy](https://github.com/kuberhealthy/kuberhealthy). The example uses the official `checkclient` package from the Kuberhealthy project, which you can import into your own Go checks.

## Using the Kuberhealthy check client

Import the client and report success or failure:

```go
import checkclient "github.com/kuberhealthy/kuberhealthy/v3/pkg/checkclient"

func runCheck() error {
    // do some work...
    if problem {
        return checkclient.ReportFailure([]string{"something went wrong"})
    }
    return checkclient.ReportSuccess()
}
```

The client expects the `KH_REPORTING_URL` and `KH_RUN_UUID` environment variables, which are provided by Kuberhealthy when the check runs.

## Example program

`cmd/example/main.go` demonstrates using `checkclient` to report either success or failure based on the `FAIL` environment variable.

## Building

```sh
make build
make docker-build IMAGE=yourrepo/example-check:tag
make docker-push IMAGE=yourrepo/example-check:tag
```

## Deploying

Create a `KHCheck` that references the image you built:

```yaml
apiVersion: kuberhealthy.github.io/v2
kind: KHCheck
metadata:
  name: example-check
spec:
  runInterval: 1m
  timeout: 30s
  podSpec:
    containers:
    - name: example
      image: yourrepo/example-check:tag
      env:
      - name: FAIL
        value: "true"
```

Apply the resource to any cluster running Kuberhealthy:

```sh
kubectl apply -f khcheck.yaml
```
