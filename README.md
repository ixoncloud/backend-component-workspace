# IXON Backend Component Workspace

Welcome to your workspace for developing backend component for the IXON Cloud. Note that creating backend components requires you to be able to write Python code.

This workspace will contain all of your different web hosted functions. You can download this repository as a ZIP file, and check it into your preferred versioning system.

## Requirements

- Python 3.9 or higher.
- [zip](https://infozip.sourceforge.net/Zip.html) for building a bundle.
- [curl](https://curl.se/) for deploying to IXON Cloud.
- [Docker](https://www.docker.com/) for setting up a DocumentDB for development

## Getting started

To get started, download this project as a ZIP, and extract it to your desired location.

To run the project, no additional commands are required, as this is automatically sets up your virtual environment and installs dependencies.

```sh
make run
```

This project already includes an example function, which you can find in **[this file](./functions/example.py)**. Please see [Developing Cloud Functions](https://developer.ixon.cloud/docs/tutorial-developing-a-backend-component) to find out how you can run and test your function.

## Bundling for deployment

This command creates a file `bundle.zip` for deployment to IXON Cloud. 

```sh
make bundle
```

It will include all Python files in the `functions` directory (recursively) that do **not** match `test_*.py` or `*_test.py` (standard [pytest filenames](https://docs.pytest.org/en/7.1.x/getting-started.html#run-multiple-tests)). 

## Deployment

This command creates and deploys the bundle to IXON Cloud.

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

