FROM ruby:2.6.6

RUN apt-get update -qq \
&& apt-get install -y nodejs postgresql-client
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn
ADD ./ /landing_page
WORKDIR /landing_page
RUN bundle install

EXPOSE 3000

CMD ["bash"]