# Use latest ruby image by default, version can be specified for docker
# passing 'ruby_image_version=version' to docker's build-arg flag
ARG ruby_image_version=latest
FROM ruby:${ruby_image_version}

WORKDIR /usr/src

# Make a Gemfile on the image's workdir using supplied config values
COPY config.json make_gemfile.rb ./
RUN ruby make_gemfile.rb

# Install Rails on the image (as per Gamfile)
RUN bundle install

CMD ["rails", "-v" ]
