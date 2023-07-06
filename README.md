#  k3d - Tilt (Example FastAPI & Helm) 

Simple example showcasing an option for a local development setup for python apps in kubernetes.

You need these tools to set this up and try it for yourself:
- [docker](https://www.docker.com): this is where the local cluster will be hosted
- [k3d](https://k3d.io): installs a k3s cluster in you docker
- [kubectl](https://kubernetes.io/docs/tasks/tools/): the means of interacting with the kubernetes cluster
- [helm](https://k3d.io): package manager for kubernetes
- [tilt](https://tilt.dev): smart rebuilds and live updates making your live easier

## Installing the cluster
Once you installed above and cloned this repository you create a local cluster using:
```
make up
```

## Running tilt
```
tilt up

t$ tilt up
Tilt started on http://localhost:10350/
v0.33.1, built 2023-06-28

(space) to open the browser
(s) to stream logs (--stream=true)
(t) to open legacy terminal mode (--legacy=true)
(ctrl-c) to exit
Tilt started on http://localhost:10350/
v0.33.1, built 2023-06-28
I0706 21:51:39.818031   44303 handler.go:232] Adding GroupVersion tilt.dev v1alpha1 to ResourceManager

Initial Build
Loading Tiltfile at: /home/davar/TILT/k3d-tilt-development/Tiltfile
📦 Building
Building docker image:  fastapi-example:latest
🚀 Deploying
Running: helm template fastapi-example /home/davar/TILT/k3d-tilt-development/charts --include-crds --values ./charts/values.yaml
🔧 Configuring
mounting local path:  /projects/app
Successfully loaded Tiltfile (127.423741ms)
Auto-detected local registry from environment: &RegistryHosting{Host:127.0.0.1:15000,HostFromClusterNetwork:registry.localhost:5000,HostFromContainerRuntime:registry.localhost:5000,Help:https://k3d.io/usage/guides/registries/#using-a-local-registry,SingleName:,}
fastapi-exam… │ 
fastapi-exam… │ Initial Build
fastapi-exam… │ STEP 1/1 — Deploying
fastapi-exam… │      Applying YAML to cluster
fastapi-exam… │ 
fastapi-exam… │ Initial Build
fastapi-exam… │ STEP 1/3 — Building Dockerfile: [fastapi-example:latest]
fastapi-exam… │ Building Dockerfile for platform linux/amd64:
fastapi-exam… │   FROM python:3.10.5-alpine3.16
fastapi-exam… │   
fastapi-exam… │   COPY ./scripts/start.sh /start.sh
fastapi-exam… │   RUN chmod +x /start.sh
fastapi-exam… │   
fastapi-exam… │   RUN mkdir -p /app
fastapi-exam… │   WORKDIR /app
fastapi-exam… │   
fastapi-exam… │   COPY ./requirements.txt /app/requirements.txt
fastapi-exam… │   RUN pip3 install --no-cache-dir -r requirements.txt
fastapi-exam… │   
fastapi-exam… │   COPY ./app /app
fastapi-exam… │   ENV PYTHONPATH=/app
fastapi-exam… │   
fastapi-exam… │   ENTRYPOINT /start.sh
fastapi-exam… │ 
fastapi-exam… │ 
fastapi-exam… │      Building image
fastapi-exam… │      Objects applied to cluster:
fastapi-exam… │        → fastapi-example-local-sc:storageclass
fastapi-exam… │        → fastapi-example-local-pv:persistentvolume
fastapi-exam… │        → fastapi-example-local-pvc:persistentvolumeclaim
fastapi-exam… │ 
fastapi-exam… │      Step 1 - 0.20s (Deploying)
fastapi-exam… │      DONE IN: 0.20s 
fastapi-exam… │ 
fastapi-exam… │      [1/8] FROM docker.io/library/python:3.10.5-alpine3.16@sha256:a746f64081fca7d6368935750ffcbf04d447cb0131408c60cbf1a4392981890a
fastapi-exam… │      [background] read source files
fastapi-exam… │      [background] read source files 1.62kB [done: 857ms]
fastapi-exam… │      [2/8] COPY ./scripts/start.sh /start.sh [cached]
fastapi-exam… │      [3/8] RUN chmod +x /start.sh [cached]
fastapi-exam… │      [4/8] RUN mkdir -p /app [cached]
fastapi-exam… │      [5/8] WORKDIR /app [cached]
fastapi-exam… │      [6/8] COPY ./requirements.txt /app/requirements.txt [cached]
fastapi-exam… │      [7/8] RUN pip3 install --no-cache-dir -r requirements.txt [cached]
fastapi-exam… │      [8/8] COPY ./app /app [cached]
fastapi-exam… │      exporting to image
fastapi-exam… │      exporting to image [done: 1.084s]
fastapi-exam… │ 
fastapi-exam… │ STEP 2/3 — Pushing 127.0.0.1:15000/fastapi-example:tilt-e1eda2f51c578eea
fastapi-exam… │      Pushing with Docker client
fastapi-exam… │      Authenticating to image repo: 127.0.0.1:15000
fastapi-exam… │      Sending image data
fastapi-exam… │      652f99b6b251: Pushing [==================================================>]     512B
fastapi-exam… │      38160c005ddb: Pushing [=================================================> ]     512B/520B
fastapi-exam… │      e95c491085d9: Pushing   2.56kB
fastapi-exam… │      5f70bf18a086: Pushing  1.024kB
fastapi-exam… │      00c1b8396424: Pushing [>                                                  ]  215.6kB/21.19MB
fastapi-exam… │      652f99b6b251: Pushed 
fastapi-exam… │      5f70bf18a086: Pushed 
fastapi-exam… │      e95c491085d9: Pushed 
fastapi-exam… │      00c1b8396424: Pushed 
fastapi-exam… │      38160c005ddb: Pushed 
fastapi-exam… │      be7d38079d7c: Pushing [=============================>                     ]     512B/870B
fastapi-exam… │      152bb10de66f: Pushing [=============================>                     ]     512B/870B
fastapi-exam… │      75e73dee76a3: Pushing [>                                                  ]  132.1kB/10.18MB
fastapi-exam… │      152bb10de66f: Pushed 
fastapi-exam… │      be7d38079d7c: Pushed 
fastapi-exam… │      0d510656312d: Pushing [==================================================>]     512B
fastapi-exam… │      61046873a9a1: Pushing [>                                                  ]  303.4kB/30.15MB
fastapi-exam… │      75e73dee76a3: Pushed 
fastapi-exam… │      0d510656312d: Pushed 
fastapi-exam… │      dc6b8d77e79b: Pushing [>                                                  ]  18.43kB/1.797MB
fastapi-exam… │      ec34fcc1d526: Pushing [>                                                  ]  68.61kB/5.529MB
fastapi-exam… │      dc6b8d77e79b: Pushed 
fastapi-exam… │      ec34fcc1d526: Pushed 
fastapi-exam… │      61046873a9a1: Pushed 
fastapi-exam… │ 
fastapi-exam… │ STEP 3/3 — Deploying
fastapi-exam… │      Applying YAML to cluster
fastapi-exam… │      Objects applied to cluster:
fastapi-exam… │        → fastapi-example:serviceaccount
fastapi-exam… │        → fastapi-example-configmap:configmap
fastapi-exam… │        → fastapi-example:service
fastapi-exam… │        → fastapi-example:deployment
fastapi-exam… │        → fastapi-example:ingress
fastapi-exam… │ 
fastapi-exam… │      Step 1 - 5.72s (Building Dockerfile: [fastapi-example:latest])
fastapi-exam… │      Step 2 - 10.26s (Pushing 127.0.0.1:15000/fastapi-example:tilt-e1eda2f51c578eea)
fastapi-exam… │      Step 3 - 0.09s (Deploying)
fastapi-exam… │      DONE IN: 16.06s 
fastapi-exam… │ 
fastapi-exam… │ 
fastapi-exam… │ Tracking new pod rollout (fastapi-example-f8977bd8c-4qbhk):
fastapi-exam… │      ┊ Scheduled       - <1s
fastapi-exam… │      ┊ Initialized     - (…) Pending
fastapi-exam… │      ┊ Ready           - (…) Pending
fastapi-exam… │ [event: pod fastapi-example-f8977bd8c-4qbhk] Pulling image "registry.localhost:5000/fastapi-example:tilt-e1eda2f51c578eea"
fastapi-exam… │ [event: pod fastapi-example-f8977bd8c-4qbhk] Successfully pulled image "registry.localhost:5000/fastapi-example:tilt-e1eda2f51c578eea" in 18.904196478s
fastapi-exam… │      ┊ Scheduled       - <1s
fastapi-exam… │      ┊ Initialized     - <1s
fastapi-exam… │      ┊ Ready           - 21s
fastapi-exam… │ *** running in development mode!!! ***
fastapi-exam… │ INFO:     Will watch for changes in these directories: ['/app']
fastapi-exam… │ INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
fastapi-exam… │ INFO:     Started reloader process [8] using statreload
fastapi-exam… │ INFO:     Started server process [10]
fastapi-exam… │ INFO:     Waiting for application startup.
fastapi-exam… │ INFO:     Application startup complete.
fastapi-exam… │ INFO:     10.42.1.1:43722 - "GET / HTTP/1.1" 200 OK
fastapi-exam… │ INFO:     10.42.1.1:43814 - "GET / HTTP/1.1" 200 OK
fastapi-exam… │ INFO:     10.42.1.1:43816 - "GET / HTTP/1.1" 200 OK
fastapi-exam… │ INFO:     10.42.1.1:43922 - "GET / HTTP/1.1" 200 OK
fastapi-exam… │ INFO:     10.42.1.1:43920 - "GET / HTTP/1.1" 200 OK

### Check
$ curl localhost
{"Hello":"World-2"}
```

This will build and install everything. It will watch your files for changes and updates the necessary parts where needed.

Clean 
```
make down
```
