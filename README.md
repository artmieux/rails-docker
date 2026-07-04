# Rails Docker

Generate new Rails apps without installing Ruby or Rails locally.

Bootstrap a Rails project using a Docker image — no need to install Ruby, rbenv, or match gem versions on your machine just to run `rails new`.

## Prerequisites

- [Docker Desktop](https://docs.docker.com/desktop/)
- [jq](https://jqlang.github.io/jq/) — a lightweight JSON processor (install via `brew install jq` on macOS)

## Getting Started

Clone this repository to your local machine:

```sh
git clone git@github.com:artmiex/rails-docker.git
cd rails-docker
```

Make the scripts executable:

```sh
chmod +x build-image rails-docker
```

## Specifying versions

Edit `config.json` to pin versions. Empty values default to `latest`.

```json
{
  "RUBY_IMAGE_VERSION":   "3.0.0",
  "RUBY_VERSION":         "3.0.0",
  "RAILS_VERSION":        "7.0.0"
}
```

- **`RUBY_IMAGE_VERSION`** — which `ruby:x.y.z` base image Docker pulls.
- **`RUBY_VERSION`** — writes `ruby 'x.y.z'` into the Gemfile so Bundler enforces it at runtime.
- **`RAILS_VERSION`** — the Rails gem version installed in the image.

`RUBY_IMAGE_VERSION` and `RUBY_VERSION` are independent. You can pin one without the other. If `RUBY_VERSION` is set, it must match `RUBY_IMAGE_VERSION` or Bundler will refuse to install.

## Building the Docker image

```sh
./build-image [-h] [-p PLATFORM]
```

This builds a new Docker Ruby image with Rails installed. The image is tagged as both `rails-docker` (convenience alias for the latest build) and `rails-docker-<ruby_v>-<rails_v>` (versioned, so multiple configurations can coexist).

Use `-p` to set the target platform (e.g. `linux/amd64` for Apple Silicon Macs to avoid native gem compilation issues). Pass `-h` to see usage details.

## Installing the rails-docker script

Copy the `rails-docker` script into a directory on your `$PATH` so it can be used from any directory:

```sh
sudo cp rails-docker /usr/local/bin
```

This only needs to be repeated if the script itself is updated.

## Creating a new Rails app

```sh
rails-docker [-t ruby_v-rails_v] [-h] new myproject --skip-bundle
cd myproject
bundle install
```

Use `-t` to select a specific versioned image (matching the tag suffix from `build-image`). The `rails-docker-` prefix is added automatically.

> The `--skip-bundle` option is recommended to avoid compilation issues when compiling from a container on certain platforms. Running `bundle install` locally on the project folder avoids these issues.

## Running other Rails commands

Any Rails command can be invoked, not just `new`:

```sh
rails-docker [-t ruby_v-rails_v] rails_command [rails_command_parameters]
```

This runs the command inside the latest image (or the versioned image if `-t` is used), passing all arguments through to `rails`.

Pass `-h` to see usage details.
