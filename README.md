# IXON Backend Component Workspace

Welcome to your workspace for developing Cloud Functions for the IXON Cloud. Note that creating Cloud Functions requires you to be able to write Python code.

This workspace will contain all of your different web hosted functions. You can download this repository as a ZIP file, and check it into your preferred versioning system.

## Requirements

- Python 3.10 or higher (Functions are run in production with Python 3.10).
- [zip](https://infozip.sourceforge.net/Zip.html) for building a bundle.
- [curl](https://curl.se/) for deploying to IXON Cloud.
- [Docker](https://www.docker.com/) for setting up a DocumentDB for development

## Getting started

To get started, download this project as a ZIP, and extract it to your desired location.

To run the project, no additional commands are required, as this is automatically sets up your virtual environment and installs dependencies.

```sh
make run
```

This project already includes an example function, which you can find in **[this file](./functions/example.py)**. Please see [Developing Cloud Functions](https://developer.ixon.cloud/docs/tutorial-developing-a-cloud-function) to find out how you can run and test your function.



## Deployment to IXON Cloud

> The deployment requires a **company ID** and a **page-component-template ID**. Please refer to the [Getting Started](https://developer.ixon.cloud/docs/getting-started-2) on our developer website how to obtain these (step 4. and 5.)

This command creates a bundle and deploys it to IXON Cloud.

```sh
make deploy
```

This command requires two additional files to be created in the root of the project:

- `.env`, containing the company and template id. This file can be checked into version control.
- `.accesstoken`, containing a valid access token, this is the string of 32 characters that can be found in the `Authorization` header of an API call with the network inspector while browsing the IXON Portal. This file should not be checked into version control.

Example `.env` file:
```make
IXON_API_COMPANY_ID=1111-2222-3333-4444-5555
IXON_API_TEMPLATE_ID=a1b2c3d4e5f6
```

Example `.accesstoken` file:
```
hAeD80dCreaZanlUkzh4nPuPpBaop3ku
```

## Other commands

Some other commands that may come in handy.

This commands sets up your virtual python environment without starting the ixoncdkingress.

```sh
make py-venv-dev
```

This commands cleans up your virtual python environment setup for this project.

```sh
make py-distclean
```

## DocumentDB Client

This project contains a client that can interface with a Document Store. When booting up the workspace
a Docker container with a Document Store is automatically created. Every time you restart your function, the
container will be removed and your document store reset.

To read more about how to use the document store please refer to: [Using the Document Store](https://developer.ixon.cloud/docs/document-store)
