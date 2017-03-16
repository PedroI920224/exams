FROM ubuntu:latest
MAINTAINER info@fluvip.com

RUN apt-get update -y
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get update -y
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
RUN apt-get install -y git-core
RUN apt-get update -y
RUN apt-get install -y openssl zlib1g zlib1g-dev libyaml-dev libxslt-dev autoconf libc6-dev automake libtool bison \
  libcurl4-openssl-dev \
  libffi-dev libssl-dev \
  libxml2-dev \
  imagemagick libmagickwand-dev \
  gcc \
  libpq-dev \
  wget

RUN apt-get install -y libreadline-dev
RUN apt-get install -y vim
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y postgresql-client-9.4
#COPY ./.ssh /root/.ssh/

RUN cd /tmp && \
  wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.3.tar.gz && \
  tar zxfv ruby-2.3.3.tar.gz && \
  cd ruby-2.3.3 && \
  ./configure && make && make install && \
  cd .. && rm -fr ruby*

RUN gem install bundler
RUN mkdir /exams
WORKDIR /influtech
RUN bundle config --global silence_root_warning 1
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update
RUN apt-get install -y unzip xvfb
RUN wget -N http://chromedriver.storage.googleapis.com/2.16/chromedriver_linux64.zip && \
  unzip chromedriver_linux64.zip && \
  chmod +x ./chromedriver && \
  cp ./chromedriver /usr/local/share/ && \
  ln -s /usr/local/share/chromedriver /usr/bin/chromedriver && \
  rm ./chromedriver*

COPY ./start-bundle-exec.sh /exams/
ENTRYPOINT ["./start-bundle-exec.sh"]
