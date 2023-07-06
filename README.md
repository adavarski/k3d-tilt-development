# FastAPI - Helm - k3d - Tilt Example

Simple example showcasing an option for a local development setup for python apps in kubernetes.

You need these tools to set this up and try it for yourself:
1. [docker](https://www.docker.com): this is where the local cluster will be hosted
1. [k3d](https://k3d.io): installs a k3s cluster in you docker
1. [kubectl](https://kubernetes.io/docs/tasks/tools/): the means of interacting with the kubernetes cluster
1. [helm](https://k3d.io): package manager for kubernetes
1. [tilt](https://tilt.dev): smart rebuilds and live updates making your live easier

## Installing the cluster
Once you installed above and cloned this repository you create a local cluster using:
```
make up
```

or 
```
k3d cluster create --config infra-dev-config.yaml --volume "$PWD:/projects@servers:*;agents:*"
```

## Running tilt
```
tilt up
```

This will build and install everything. It will watch your files for changes and updates the necessary parts where needed.