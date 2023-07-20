# IXON Backend Component Workspace

Welcome to your workspace for developing backend component for the IXON Cloud. Note that creating backend components requires you to be able to write Python code.

This workspace will contain all of your different web hosted functions. You can download this repository as a ZIP file, and check it into your preferred versioning system.

## Requirements

- Python 3.9 or higher.

## Getting started

To get started, download this project as a ZIP, and extract it to your desired location.

To run the project, no additional commands are required, as this is automatically sets up your virtual environment and installs dependencies.

```sh
make run
```

This project already includes an example function, which you can find in **[this file](./functions/example.py)**. Please see [Developing Cloud Functions](https://developer.ixon.cloud/docs/tutorial-developing-a-backend-component) to find out how you can run and test your function.

## Bundling for deployment

This command creates a file `bundle.zip` that you can send to IXON Support for deployment. 

```sh
make bundle
```

It will include all Python files in the `functions` directory (recursively) that do **not** match `test_*.py` or `*_test.py` (standard [pytest filenames](https://docs.pytest.org/en/7.1.x/getting-started.html#run-multiple-tests)). 

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

