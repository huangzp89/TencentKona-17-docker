FROM ubuntu:22.04 as build
RUN apt update && apt install wget -y
RUN wget https://github.com/Tencent/TencentKona-17/releases/download/TencentKona-17.0.8/TencentKona-17.0.8.b1-jdk_linux-x86_64.tar.gz
RUN tar zxvf TencentKona-17.0.8.b1-jdk_linux-x86_64.tar.gz

FROM ubuntu:22.04
ENV JAVA_HOME=/app/TencentKona-17.0.8.b1 
ENV PATH=${JAVA_HOME}/bin:$PATH
RUN apt update && apt full-upgrade -y && apt install libfreetype6 fontconfig -y
COPY --from=build /TencentKona-17.0.8.b1/ /app/TencentKona-17.0.8.b1/
WORKDIR /app/