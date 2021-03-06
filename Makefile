VERSION=$(shell git rev-parse --short HEAD)
IMAGE_PREFIX=jupyterhub/k8s
JUPYTERHUB_VERSION ?= 0.8.0rc1
PUSH_IMAGES=no
BUILD_ARGS=--build-arg JUPYTERHUB_VERSION=$(JUPYTERHUB_VERSION)

images: build-images push-images
build-images: build-image/hub build-image/singleuser-sample
push-images: push-image/hub push-image/singleuser-sample

build-image/%:
	cd images/$(@F) && \
	docker build -t $(IMAGE_PREFIX)-$(@F):v$(VERSION) . $(BUILD_ARGS)

push-image/%:
	docker push $(IMAGE_PREFIX)-$(@F):v$(VERSION)

package-chart:
	helm package jupyterhub
