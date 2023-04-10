.PHONY: helm-docs
helm-docs:
	@docker run --rm --volume "$(shell pwd):/helm-docs" -u "$(shell id -u)" jnorwood/helm-docs:latest --template-files=README.md.gotmpl
	mv linkerd-multicluster-link/README.md .

