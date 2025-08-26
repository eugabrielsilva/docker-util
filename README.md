# docker-util

A simple command-line utility for managing Docker containers, images, and resources.

## Installation

Clone this repository and add `docker-util` to your `$PATH`:

```shell
git clone https://github.com/yourusername/docker-util.git
cd docker-util
chmod +x docker-util
sudo mv docker-util /usr/local/bin/
```

## Usage

You need [Docker](https://docs.docker.com/get-docker/) and [fzf](https://github.com/junegunn/fzf) installed.

```shell
docker-util <command> [options]
```

## Commands

| Command              | Description                                                                             |
| -------------------- | --------------------------------------------------------------------------------------- |
| `start`              | Starts Docker Compose (`docker compose up -d`)                                          |
| `build <image>`      | Builds a Docker image with the given name                                               |
| `stop [container]`   | Stops a container (or selects one interactively if not provided)                        |
| `stop-all`           | Stops all running containers                                                            |
| `bash [user] [cont]` | Opens a Bash shell inside a container (default user: `root`)                            |
| `remove [container]` | Removes a container (or selects one interactively if not provided)                      |
| `remove-image [img]` | Removes a Docker image (or selects one interactively if not provided)                   |
| `list`               | Shows stats for a selected running container                                            |
| `clear [type]`       | Cleans Docker resources (`containers`, `images`, `volumes`, `networks`, `cache`, `all`) |

## Credits

Developed by [Gabriel Silva](https://github.com/eugabrielsilva) under the MIT License.
