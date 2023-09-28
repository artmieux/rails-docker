# Rails Docker

### Dockerfile and scripts for creating Ruby on Rails apps using a Docker image

Using Bundler and Ruby version managers like rbenv we can track and install the exact ruby and gems versions that we need for our projects. Nevertheless, when creating a new Rails application we might not have the exact Ruby and Rails versions we want to use installed on our system, and it can be cumbersome to install and mantain these versions for the sole purpose of creating new projects.

This repository provides a Dockerfile and a set of scripts that allow us to easily build a Docker image and use it to create new Rails apps.

## Getting Started

Make sure you have [Docker Desktop](https://docs.docker.com/desktop/) installed

### Cloning the repository

To begin, clone this repository to your local machine:

```sh
git clone git@github.com:artmieussens/rails_docker.git
cd rails_docker
```

### Making Scripts Executable

Ensure that the scripts build_image and rails_docker are set to be executable:

```sh
chmod +x build_image rails_docker
```

### Specifying versions

By default, the latest Docker Ruby image and Rails version will be used, but the config.json file can be used to specify the Ruby image, Ruby, and Rails versions to be used.

For example:

```json
{
  "RUBY_IMAGE_VERSION":     "3.0.0",
  "RUBY_VERSION":           "3.0.0",
  "RAILS_VERSION":          "7.0.0"
}
```

Any of these values set to an empty string will use the 'latest' version.

> If the RUBY_VERSION is specified, it must match the RUBY_IMAGE VERSION value, as the Rails installation on the image will require that specific Ruby version to be used.

## Building the Docker image

Executing this command will build a new Docker Ruby image and install Rails on it 

```sh
./build-image
```

The Docker image will be tagged both as rails-docker-[ruby_version]-[rails_version] and as rails-docker, so specific images can be run with the long tags and rails-docker will always referr to the latest image created

## Installing the rails-docker script

Copying the rails-docker script into a directory included in your $PATH will allow it to be used from within any directory

For example:

```sh
sudo cp rails-docker /usr/local/bin
```

This only has to be repeated if changes are made to the rails-docker script

## Creating a new Rails App

To create a new rails project in your local directory, run:

```sh
rails_docker [-t ruby_v-rails_v] new myproject --skip-bundle [other flags and parameters for rails new]
cd myproject
bundle install
```

> the --skip-bundle option is recommended to avoid compiling issues when compiling from a container in certain platforms. Running bundler locally on the project's folder avoids these issues.

## Running rails on a container

Rails can be run within a commands other than new

```sh
rails_docker [-t ruby_v-rails_v] rails_command [rails_command_parameters]
```

This will run rails on the latest created image, or on the image tagged as rails-docker-ruby_v-rails_v if the -t option is used, passing all the parameters and options provided at the end
