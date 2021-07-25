FROM gitpod/workspace-full
RUN curl -fsSL https://deno.land/x/install/install.sh | sh -s v1.12.1 \
  && echo 'export DENO_INSTALL="/home/gitpod/.deno"' >> ~/.bashrc \
  && echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc