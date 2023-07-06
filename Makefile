.PHONY: all build-all build help up down

APP_NAME:=fastapi-example
VERSION:=0.0.1
REGISTRY=registry.localhost:15000
IMAGE=${REGISTRY}/${APP_NAME}
TAG_ALIAS=latest

all: up build-all

build-all: build tag-alias push

build: 
	$(info Building ${IMAGE}:${VERSION} ...)
	docker build --pull -t "${APP_NAME}:${VERSION}" .

tag-alias:
	docker tag ${APP_NAME}:${VERSION} ${APP_NAME}:${TAG_ALIAS}
	docker tag ${APP_NAME}:${VERSION} ${IMAGE}:${VERSION}
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:${TAG_ALIAS}

push:
	docker push -a ${IMAGE}

### local k3s cluster
CLUSTER_CONFIG = infra-dev-config.yaml

HOST_VOLUME:=$(abspath $(dir $(firstword $(MAKEFILE_LIST)))/)
NODE_VOLUME=/projects

## Uncomment the NGINX lines below if you want to replace the default traefik by the nginx ingress controller.
#NGINX_INGRESS_VERSION=4.0.19
#NGINX_INGRESS_NAMESPACE=ingress-nginx
#NGINX_HELM_URL=https://github.com/kubernetes/ingress-nginx/releases/download/helm-chart-${NGINX_INGRESS_VERSION}/ingress-nginx-${NGINX_INGRESS_VERSION}.tgz
export K3D_FIX_DNS=1



up:
	@echo "*** Installing k3d cluster ... "
	k3d cluster create --config ${CLUSTER_CONFIG} --volume '${HOST_VOLUME}:${NODE_VOLUME}@server:*;agent:*'
	#k3d cluster create --config ${CLUSTER_CONFIG} --volume '${HOST_VOLUME}:${NODE_VOLUME}@server:*;agent:*' --k3s-arg '--no-deploy=traefik@server:*'
	#@echo "*** Installing NGINX Ingress from: $(NGINX_HELM_URL)"
	#helm install --namespace ${NGINX_INGRESS_NAMESPACE} --create-namespace ${NGINX_INGRESS_NAMESPACE} ${NGINX_HELM_URL}
	#@echo "*** Watching rollout status of nginx ingress, nginx ingress is available when this exits ..."
	#kubectl rollout status --namespace ${NGINX_INGRESS_NAMESPACE} deployment.apps/ingress-nginx-controller

down:
	k3d cluster delete --config ${CLUSTER_CONFIG}

#Helm install name
export HELM_NAME=${APP_NAME}
export USE_IMAGE=${IMAGE}
HELM_CHART_PATH = ./charts

# List of helm targets
HELM_TARGETS = all install install-dry upgrade upgrade-all upgrade-dry dep-build dep-update uninstall
# Add all helm targets with the "helm-" prefix.
HELM_TARGETS_PREFIX = $(addprefix helm-, $(HELM_TARGETS))
$(HELM_TARGETS_PREFIX):
	$(MAKE) -C $(HELM_CHART_PATH) $(subst helm-,,$@)

help:
	@echo '*** Usage of this file:'
	@echo 'make           : Setup local dev environment using k3d (see .k3s/k3d for configs) AND build and push all local images'
	@echo 'make up        : Setup local dev environmetn (k8s cluster and registry)'
	@echo 'make down      : Teardown local dev environment'
	@echo 'make build-all : Build and push the images to the local registry'
	@echo 'make build     : Build the image without pushing'
	@echo 'make tag-alias : Make a tag alias'
	@echo 'make push      : Push the images to the local registry'
	@echo
	@echo '*** Some helm related commands:'
	@echo 'make helm-all         : Install helm chart including updating and building dependencies'
	@echo 'make helm-install     : Install helm chart in the current kubectl context'
	@echo 'make helm-install-dry : Do a simulation of an installation'
	@echo 'make helm-upgrade     : Upgrade the helm chart as is'
	@echo 'make helm-upgrade-all : Upgrade the helm chart including updating and building dependencies'
	@echo 'make helm-upgrade-dry : Do a simulation of an upgrade'
	@echo 'make helm-dep-build   : Build the chart dependencies from the Chart.lock file values.yaml is not evaluated'
	@echo 'make helm-dep-update  : Refresh the and download the dependencies from the Chart.yaml file'
	@echo 'make helm-uninstall   : Uninstall the helm release'

