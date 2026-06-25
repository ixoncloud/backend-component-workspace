# IXON Backend Component Workspace

Welcome to your workspace for developing Cloud Functions for the IXON Cloud. Writing Cloud Functions requires Python.

This workspace holds all of your web-hosted functions. Download it as a ZIP and check it into your preferred version control system.

## Requirements

There are two ways to run this workspace. Both require [Docker](https://www.docker.com/) (Docker Desktop) — it hosts the development DocumentDB, and the Dev Container itself runs on it.

- **[Dev Container](#dev-container-recommended) (recommended).** Provides the correct Python version, `make`, and `zip` with no local installs, and behaves the same on Windows, macOS, and Linux. Also needs an editor with Dev Container support, such as [VS Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
- **[Local setup](#local-setup).** Runs the `make` commands directly on your machine. `make` ships with macOS and Linux; on Windows, use [WSL](https://learn.microsoft.com/en-us/windows/wsl/). Also needs:
  - [Python](https://www.python.org/downloads/) matching your `ixoncdkingress` version (see table). This is the version the Cloud Function runs in production, so match it exactly rather than using a newer one.
  - [zip](https://infozip.sourceforge.net/Zip.html) for building a bundle.

| ixoncdkingress | Python |
| -------------- | ------ |
| 1.x.x          | 3.12.x |

## Getting started

Either path sets up the virtual environment and installs dependencies for you. Afterwards, explore the example in [functions/example.py](./functions/example.py) and the [Development of Cloud Functions](https://developer.ixon.cloud/docs/development-of-cloud-functions) guide to write and test your own.

### Dev Container (recommended)

Keep the project on a real local disk. Docker cannot bind-mount from cloud-synced or virtual drives (Google Drive, OneDrive), and the container will fail to start with `bind source path does not exist`. On Windows, clone it into the WSL2 filesystem (e.g. `~/projects/…`) for the smoothest setup and best performance; a plain folder like `C:\Users\<you>\projects\…` also works.

1. Install the [requirements](#requirements).
2. Open this folder in your editor and reopen it in the Dev Container (in VS Code: **Reopen in Container**, or run **Dev Containers: Reopen in Container** from the command palette). On first creation the container builds and provisions the virtual environment automatically.
3. Run the project from the integrated terminal:

   ```sh
   make run
   ```

Port `8080` (where `ixoncdkingress` serves) is forwarded automatically, and the DocumentDB runs inside the container.

### Local setup

1. Install the [requirements](#requirements).
2. Run the project — the first run provisions the virtual environment, then starts the workspace:

   ```sh
   make run
   ```

## Deployment to IXON Cloud

```sh
make deploy
```

This builds a bundle and deploys it to IXON Cloud. It needs a Company ID, a Cloud Function public ID, and authorization via an access token — see [Deploy and publish](https://developer.ixon.cloud/docs/how-to-register-deploy-and-publish-a-cloud-function#deploy-and-publish) on our developer website for how to obtain them. Provide them through two files in the project root:

- `.env` — the company and template IDs. Safe to commit.
- `.accesstoken` — a valid access token: the 32-character string from the `Authorization` header of an API call, visible in the network inspector while browsing the IXON Portal. Do **not** commit this.

Example `.env`:

```make
IXON_API_COMPANY_ID=1111-2222-3333-4444-5555
IXON_API_TEMPLATE_ID=a1b2c3d4e5f6
```

Example `.accesstoken`:

```
hAeD80dCreaZanlUkzh4nPuPpBaop3ku
```

## Other commands

- `make py-venv-dev` — set up the virtual environment without starting `ixoncdkingress`.
- `make py-distclean` — remove this project's virtual environment.

## DocumentDB client

This project includes a client for a Document Store. The store runs as a Docker container that is created when the workspace boots and reset each time you restart your function. See [Document Store](https://developer.ixon.cloud/docs/document-store) for usage.

## Support

For more information and support, see our [developer website](https://developer.ixon.cloud/).
