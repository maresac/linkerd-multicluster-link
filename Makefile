.PHONY: helm-docs
helm-docs:
	@docker run --rm --volume "$(shell pwd):/helm-docs" -u "$(shell id -u)" jnorwood/helm-docs:latest --chart-search-root=./linkerd-multicluster-link --template-files=README.md.gotmpl
	@mv linkerd-multicluster-link/README.md .

