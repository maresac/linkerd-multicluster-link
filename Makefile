.PHONY: helm-docs
helm-docs:
	@docker run --rm --volume "$(shell pwd):/helm-docs" -u "$(shell id -u)" jnorwood/helm-docs:latest
