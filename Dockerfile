FROM ubuntu:18.04

# In install dependencies packages
RUN apt-get update && apt-get install  --no-install-recommends -y curl gnupg gnupg1 gnupg2 git locales

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs 

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y yarn

# Clean up unused packages
RUN apt-get remove -y --purge gnupg gnupg1 gnupg2 && apt-get clean

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
  && locale-gen en_US.UTF-8

ARG GIT_COMMIT=unspecified
LABEL image_name="Ubuntu image with yarn installed"
LABEL git_repository_url="https://github.com/caohhung/yarn-ubuntu/"
LABEL parent_image="ubuntu:18.04"
LABEL git_commit=$GIT_COMMIT
