FROM ubuntu:20.04
ARG GID=1000
ARG GROUPNAME=user
ARG UID=1000
ARG USERNAME=user
ENV DEBIAN_FRONTEND=noninteractive
RUN groupadd -g ${GID} ${GROUPNAME} \
    && useradd -g ${GID} -m -s /bin/bash -u ${UID} ${USERNAME} \
    && apt-get update \
    && apt-get install -y curl git unzip

# https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#running-puppeteer-in-docker
RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

USER ${USERNAME}
WORKDIR /home/${USERNAME}/

# install deno
RUN curl -fsSL https://deno.land/x/install/install.sh | sh -s v1.12.1
ENV DENO_INSTALL=/home/${USERNAME}/.deno
ENV PATH=${DENO_INSTALL}/bin:${PATH}

COPY ./ ./
CMD ["./server.ts"]