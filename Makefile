TAG?=latest
TAGS_TO_PULL?=latest
LATEST_TAG?=latest
REGISTRY=docker.io
ORGANIZATION=skimia
DOCKER_IMAGE_NAME=$(REGISTRY)/$(ORGANIZATION)/che-plugin-registry

.PHONY: pull build test tag push $(TAGS_TO_PULL)

pull: $(TAGS_TO_PULL)

$(TAGS_TO_PULL):
	@docker pull $(DOCKER_IMAGE_NAME):$(@) || echo "$(DOCKER_IMAGE_NAME):$(@) does not exist yet. Will build it."

build: ## Build docker image
	./build.sh --registry $(REGISTRY) --organization $(ORGANIZATION) --tag $(TAG)

test:
	@echo "$(DOCKER_IMAGE_NAME):$(TAG) has no tests."

tag:
	@docker tag $(DOCKER_IMAGE_NAME):$(TAG) $(DOCKER_IMAGE_NAME):$(LATEST_TAG)

push:
	docker push $(DOCKER_IMAGE_NAME)
