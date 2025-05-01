FROM public.ecr.aws/aws-cli/aws-cli:latest as release

RUN curl https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm > session-manager-plugin-test.rpm && \
    yum install -y ./session-manager-plugin-test.rpm && \
    rm -rf ./session-manager-plugin-test.rpm
