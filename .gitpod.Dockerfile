FROM gitpod/workspace-full

# install deno
RUN curl -fsSL https://deno.land/x/install/install.sh | sh -s v1.12.1 \
  && echo 'export DENO_INSTALL="/home/gitpod/.deno"' >> ~/.bashrc \
  && echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc

# https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#running-puppeteer-in-docker
RUN sudo apt-get update \
    && sudo apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && sudo apt-get update \
    && sudo apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && sudo rm -rf /var/lib/apt/lists/*