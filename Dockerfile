ARG ruby_image_version=latest
FROM ruby:${ruby_image_version}

WORKDIR /usr/src

COPY config.json make_gemfile.rb ./
RUN ruby make_gemfile.rb

RUN bundle config set --global no_document true \
    && bundle install

CMD ["rails", "-v"]
