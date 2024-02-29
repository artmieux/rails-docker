# Rails Docker

### Dockerfile and scripts for creating Ruby on Rails apps using a Docker image

Leveraging Bundler and Ruby version managers such as rbenv facilitates tracking and installation of required Ruby and gem versions for our projects. However, initializing a new Rails application may pose challenges if the desired Ruby and Rails versions are not already installed, requiring additional effort to manage these versions solely for project initiation.

This project offers a Dockerfile and accompanying scripts, streamlining the process of building a Docker image. This image enables seamless creation of new Rails applications without the need for maintaining specific Ruby and Rails versions on the local system.

## Getting Started

Make sure you have [Docker Desktop](https://docs.docker.com/desktop/) installed

### Cloning the repository

To begin, clone this repository to your local machine:

```sh
git clone git@github.com:artmieussens/rails-docker.git
cd rails-docker
```

### Making Scripts Executable

Ensure that the scripts build-image and rails-docker are set to be executable:

```sh
chmod +x build-image rails-docker
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
rails-docker [-t ruby_v-rails_v] new myproject --skip-bundle [other flags and params]
cd myproject
bundle install
```

> the --skip-bundle option is recommended to avoid compiling issues when compiling from a container in certain platforms. Running bundler locally on the project's folder avoids these issues.

## Running rails on a container

Rails can be run invoking a command other than new

```sh
rails-docker [-t ruby_v-rails_v] rails_command [rails_command_parameters]
```

This will run rails on the latest created image, or on the image tagged as rails-docker-ruby_v-rails_v if the -t option is used, passing all the parameters and options provided at the end
