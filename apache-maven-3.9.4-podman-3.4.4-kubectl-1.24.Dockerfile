FROM ubuntu:22.04 as build
RUN apt update && apt install wget -y
RUN wget https://github.com/Tencent/TencentKona-17/releases/download/TencentKona-17.0.8/TencentKona-17.0.8.b1-jdk_linux-x86_64.tar.gz
RUN tar zxvf TencentKona-17.0.8.b1-jdk_linux-x86_64.tar.gz
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz
RUN wget https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.13/2023-05-11/bin/darwin/amd64/kubectl
RUN tar zxvf apache-maven-3.9.4-bin.tar.gz

FROM ubuntu:22.04
ENV JAVA_HOME=/app/TencentKona-17.0.8.b1 
ENV PATH=${JAVA_HOME}/bin:$PATH
ENV MAVEN_HOME=/app/apache-maven-3.9.4/
ENV PATH=${PATH}:${MAVEN_HOME}/bin
RUN apt update && apt full-upgrade -y && apt install ca-certificates podman -y
COPY --from=build /TencentKona-17.0.8.b1/ /app/TencentKona-17.0.8.b1/
COPY --from=build /apache-maven-3.9.4/    /app/apache-maven-3.9.4/
COPY --from=build /kubectl /usr/local/bin/kubectl
COPY ./registries.conf /etc/containers/
WORKDIR /app/