# Rails Docker

### Dockerfile and scripts for creating Ruby on Rails apps using a Docker image

Using Bundler and Ruby version managers like rbenv we can track and install the exact ruby and gems versions that we need for our projects. Nevertheless, when creating a new Rails application we might not have the exact Ruby and Rails versions we want to use installed on our system, and it can be cumbersome to install and mantain these versions for the sole purpose of creating new projects.

This repository provides a Dockerfile and a set of scripts that allow us to easily build a Docker image and use it to create new Rails apps.

## Use guide

Clone this repository

```sh
git clone git@github.com:artmieussens/rails_docker.git
cd rails_docker
```

Make sure that the scripts build_image and rails_docker are set to executable, otherwise make them executable by running this command

```sh
chmod +x build_image rails_docker
```

### Specifying versions (optional)

By default, the latest Docker Ruby image and Rails version will be used, but the config.json file can be used to specify the Ruby image, Ruby, and Rails versions to be used.

For example:

```json
{
  "RUBY_IMAGE_VERSION":     "3.0.0",
  "RUBY_VERSION":           "3.0.0",
  "RAILS_VERSION":          "7.0.0"
}
```
Any of these values set to an empty string will use the latest version.

> If the RUBY_VERSION is specified, it must match the RUBY_IMAGE VERSION value, as the Rails installation on the image will require that specific Ruby version to be used.

### Build the Docker image

Executing this command will build a new Docker Ruby image and install Rails on it 

```sh
./build_image
```

> The docker image will be tagged as rails-docker-[ruby_version]-[rails_version] and as rails-docker, so specific images can be run with the full tag and rails-docker will always referr to the latest image created

### Install rails_docker script

To be able to use the rails_docker script from any directory, it can be installed into a directory in your $PATH

For example:

```sh
sudo cp rails_docker /usr/local/bin
```

This only has to be repeated if changes are made to the rails_docker script

#### Run rails

To run rails from a throwaway container based on an image built as explained above with the installed command as in the previous step run 

```sh
rails_docker [-t ruby_v-rails_v] [rails_commands]
```

This will run rails on the latest created image, or on the image tagged rails-docker-ruby_v-rails_v if the -t option is used, passing all the parameters and options provided at the end

### Create a new Rails App

For example, to create a new rails app, from the directory where you want the new Rails project to be created run:

```sh
rails_docker [-t ruby_v-rails_v] new myproject --skip-bundle -T
cd myproject
bundle install
```
> the --skip-bundle option is recommended to avoid compiling issues in certain platforms. It's better to run bundler from the target platform once the app has been created