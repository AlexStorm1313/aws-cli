# Containerized AWS CLI

A portable, containerized solution for running the AWS Command Line Interface through Podman, ensuring consistent CLI behavior across different environments.


## Overview

This project provides a containerized version of the AWS CLI, allowing you to run AWS commands in a consistent environment without worrying about local dependencies or version conflicts. By using containers, you can ensure that your AWS CLI experience is identical across different systems.

## Features

- **Consistent Environment**: Same AWS CLI version and dependencies regardless of host system
- **Isolated Execution**: AWS CLI runs in its own container without affecting your system
- **Credential Mapping**: Securely use your local AWS credentials from within the container
- **Tab Completion**: Full command completion support, just like the native AWS CLI
- **Current Directory Mounting**: Automatically mounts your current directory for easy file access
- **Minimal Setup**: Just add an alias and you're ready to go

## Quick Setup

Add the following to your `.bashrc`, `.zshrc`, or equivalent shell configuration file:

### Using Podman

```bash
# Create an alias for the containerized AWS CLI
alias aws="podman run --privileged --rm -i -v ~/.aws:/root/.aws -v $(pwd):/aws ghcr.io/alexstorm1313/aws-cli:latest $@"

# Enable tab completion for the containerized AWS CLI
complete -C "podman run --rm -i --entrypoint /usr/local/bin/aws_completer -e COMP_LINE -e COMP_POINT ghcr.io/alexstorm1313/aws-cli:latest $@" aws
```

### Using Docker

```bash
# Create an alias for the containerized AWS CLI
alias aws="docker run --privileged --rm -i -v ~/.aws:/root/.aws -v $(pwd):/aws ghcr.io/alexstorm1313/aws-cli:latest $@"

# Enable tab completion for the containerized AWS CLI
complete -C "docker run --rm -i --entrypoint /usr/local/bin/aws_completer -e COMP_LINE -e COMP_POINT ghcr.io/alexstorm1313/aws-cli:latest $@" aws
```

After adding these lines, restart your shell or run `source ~/.bashrc` (or equivalent) to apply the changes.

## Usage

Once the alias is set up, you can use the `aws` command as if it were installed locally:

```bash
# List S3 buckets
aws s3 ls

# Describe EC2 instances
aws ec2 describe-instances

# Any other AWS CLI command
aws [service] [command]
```

## How It Works

The alias runs the AWS CLI inside a container with the following configuration:

- `--privileged --rm -i`: Runs in privileged mode, removes the container after execution, and keeps STDIN open
- `-v ~/.aws:/root/.aws`: Mounts your local AWS credentials directory into the container
- `-v $(pwd):/aws`: Mounts your current working directory to /aws in the container
- `ghcr.io/alexstorm1313/aws-cli:latest`: Uses the latest version of the container image
- `$@`: Passes all arguments to the AWS CLI inside the container

## Configuration

### Using Different AWS Profiles

The containerized AWS CLI respects your AWS profiles:

```bash
aws --profile production s3 ls
```

### Working with Files

Since your current directory is mounted in the container, you can reference local files directly:

```bash
aws s3 cp ./localfile.txt s3://my-bucket/
```

## Building the Container Image

If you want to build the container image yourself:

```bash
git clone https://github.com/AlexStorm1313/aws-cli.git
cd aws-cli
make build
```

Then update your alias to use your local image:

### Using Podman

```bash
# Create an alias for the containerized AWS CLI
alias aws="podman run --privileged --rm -i -v ~/.aws:/root/.aws -v $(pwd):/aws localhost/aws-cli:latest $@"

# Enable tab completion for the containerized AWS CLI
complete -C "podman run --rm -i --entrypoint /usr/local/bin/aws_completer -e COMP_LINE -e COMP_POINT localhost/aws-cli:latest $@" aws
```

### Using Docker

```bash
# Create an alias for the containerized AWS CLI
alias aws="docker run --privileged --rm -i -v ~/.aws:/root/.aws -v $(pwd):/aws localhost/aws-cli:latest $@"

# Enable tab completion for the containerized AWS CLI
complete -C "docker run --rm -i --entrypoint /usr/local/bin/aws_completer -e COMP_LINE -e COMP_POINT localhost/aws-cli:latest $@" aws
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

see the LICENSE file for details.

## Acknowledgments

- AWS for the amazing AWS CLI tool
- The Podman and Docker teams for providing great container runtimes
