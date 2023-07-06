.PHONY: install install-dry uninstall dep-update dep-build upgrade upgrade-dry all upgrade-all

VALUES_FILE=./values.yaml
ifdef USE_IMAGE
EXTRA_ARGS := --set image.repository=$(USE_IMAGE)
else
EXTRA_ARGS := 
endif

all: dep-update dep-build install
upgrade-all: dep-update dep-build upgrade

dep-update:
	helm dependency update

dep-build:
	helm dependency build

install:
	$(info "Installing...")
	helm install $(HELM_NAME) ./ -f $(VALUES_FILE) $(EXTRA_ARGS)

install-dry:
	$(info "Dry installing...")
	helm install $(HELM_NAME) ./ -f $(VALUES_FILE) --dry-run $(EXTRA_ARGS)

upgrade:
	$(info "Upgrading...")
	helm upgrade $(HELM_NAME) ./ -f $(VALUES_FILE) $(EXTRA_ARGS)

upgrade-dry:
	$(info "Upgrading...")
	helm upgrade $(HELM_NAME) ./ -f $(VALUES_FILE) --dry-run $(EXTRA_ARGS)

uninstall:
	$(info "Uninstalling...")
	helm uninstall $(HELM_NAME)

