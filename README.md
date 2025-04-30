```
# Containerized AWS CLI
alias aws="podman run --privileged --rm -i -v ~/.aws:/root/.aws -v $(pwd):/aws localhost/aws-cli $@"
complete -C "podman run --rm -i --entrypoint /usr/local/bin/aws_completer -e COMP_LINE -e COMP_POINT localhost/aws-cli $@" aws
```
