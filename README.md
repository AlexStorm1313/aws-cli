```
# Containerized AWS CLI
alias aws="podman run --privileged --rm -i -v ~/.aws:/root/.aws -v $(pwd):/aws ghcr.io/alexstorm1313/aws-cli:latest $@"
complete -C "podman run --rm -i --entrypoint /usr/local/bin/aws_completer -e COMP_LINE -e COMP_POINT ghcr.io/alexstorm1313/aws-cli:latest $@" aws
```
