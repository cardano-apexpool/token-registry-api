FROM debian:stable-slim

# cardano-node version
ENV APP_PATH /app

# timezone
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# system dependencies
RUN apt update -y
RUN apt install -y \
    tmux \
    screen \
    git \
    jq \
    bc \
    wget \
    curl \
    zip \
    unzip \
    bzip2 \
    net-tools \
    tcpdump \
    tcptraceroute \
    procps \
    lsof \
    vim \
    joe \
    cron \
    python3-pip

# create folders
RUN ls -l $(dirname ${APP_PATH}) || mkdir $(dirname ${APP_PATH}) -p
RUN git clone --recurse-submodules https://github.com/cardano-apexpool/token-registry-api.git ${APP_PATH}
RUN mkdir ${APP_PATH}/db
RUN mkdir ${APP_PATH}/logs

RUN chmod 755 ${APP_PATH}/run.sh
RUN pip3 install -r ${APP_PATH}/requirements.txt

WORKDIR ${APP_PATH}
ENTRYPOINT [ "/app/run.sh" ]
