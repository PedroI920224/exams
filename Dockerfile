FROM ruby:2.3.3

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get update -y
RUN apt-get install -y nodejs
RUN mkdir /exams
WORKDIR /exams
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y postgresql-client-9.4

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

RUN mkdir /exams/src
WORKDIR /exams/src
