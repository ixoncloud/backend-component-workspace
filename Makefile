PYTHON_MINIMUN_MINOR_VER := 9
CBC_PATH := ./functions
PWD := $(shell pwd)

PYTHON_FILES := $(shell find $(CBC_PATH) -type f -name '*.py' -a ! -name 'test_*.py' -a ! -name '*_test.py')

IXON_API_BASE_URL := https://api.ayayot.com
IXON_API_VERSION := 2
IXON_API_APPLICATION_ID := 9J9IZzeT4xN4
IXON_API_COMPANY_ID :=
IXON_API_TEMPLATE_ID :=

-include .env

# ######
# Autodetect Python location and version.
# ######

# Detect echo location for command line output.
ifeq (,$(ECHO_BIN))
ifeq ($(OS),Windows_NT)
ECHO_BIN := echo
else
ECHO_BIN := $(shell which echo)
endif
endif

# Python interpreter location for the venv environment.
ifeq (,$(PYTHON_BIN))
ifeq ($(OS),Windows_NT)
PYTHON_BIN := ./venv/Scripts/python.exe
else
PYTHON_BIN := ./venv/bin/python3
endif
endif

# Python interpreter location for host machine.
ifeq (,$(wildcard $(PYTHON_BIN)))
ifeq ($(OS),Windows_NT)
HOST_PYTHON_BIN := $(shell where python)
else
HOST_PYTHON_BIN := $(shell which python3 2> /dev/null)
endif
endif

# Python interpreter version for host machine.
ifeq (,$(wildcard $(PYTHON_BIN)))
ifeq (,$(wildcard $(HOST_PYTHON_BIN)))
HOST_PYTHON_MAJOR_VER :=
HOST_PYTHON_MINOR_VER :=
else
HOST_PYTHON_MAJOR_VER := $(shell $(HOST_PYTHON_BIN) -c 'import sys ; print (sys.version_info[0])')
HOST_PYTHON_MINOR_VER := $(shell $(HOST_PYTHON_BIN) -c 'import sys ; print (sys.version_info[1])')
endif
endif

# Set the minor version to -1 if there is no minor version detected
# otherwise some future checks won't work.
ifeq (,$(HOST_PYTHON_MINOR_VER))
HOST_PYTHON_MINOR_VER := -1
endif

# ######
# Virtual Python environment setup.
# ######

$(PYTHON_BIN):
# Check if venv is already setup
ifeq (,$(wildcard $(PYTHON_BIN)))

# Check if Python could be found on the host machine.
ifeq (, $(HOST_PYTHON_MAJOR_VER))
	@echo Could not detect Python on the host system
	@false
endif

# Check Python version on the host machine is correct.
ifeq ($(HOST_PYTHON_MAJOR_VER), 2)
	@echo Python 2 is not supported
	@false
endif

# Check if HOST_PYTHON_MINOR_VER is greater than or equal to the minimun version.
ifeq ($(shell test $(HOST_PYTHON_MINOR_VER) -ge $(PYTHON_MINIMUN_MINOR_VER); echo $$?), 1)
	@echo Python version below 3.$(PYTHON_MINIMUN_MINOR_VER) in not supported
	@false
endif

# Ensure we're working with Python 3
ifeq ($(HOST_PYTHON_MAJOR_VER), 3)
	@echo Setting up virtual environment for Python 3
	$(HOST_PYTHON_BIN) -m venv ./venv
endif

	$(PYTHON_BIN) -m pip install pip setuptools wheel --upgrade
else
	@echo Venv already set up, not doing anything.
endif

./venv/pip-dev.done: $(PYTHON_BIN) requirements*.txt
	@echo Installing application dependencies 
	$(PYTHON_BIN) -m pip install --requirement requirements-dev.txt
	echo > $@

# ######
# Scripts
# ######

# Setup virtual Python environment
py-venv-dev: ./venv/pip-dev.done

# Clean up virtual Python environment
py-distclean:
	rm -rf ./venv

bundle:
ifeq ($(wildcard requirements.txt),)
	$(error No requirements.txt file found!!)
endif
ifeq ($(PYTHON_FILES),)
	$(error No Python files found!!)
endif
	rm -f bundle.zip
	zip "$(PWD)/$@" requirements.txt
	zip "$(PWD)/$@" $(PYTHON_FILES)

deploy: bundle
ifeq ($(IXON_API_COMPANY_ID),)
	$(error IXON Cloud Company ID not set, create .env and add IXON_API_COMPANY_ID=...)
endif
ifeq ($(IXON_API_TEMPLATE_ID),)
	$(error IXON Cloud Backend Component Template ID not set, create .env and add IXON_API_TEMPLATE_ID=...)
endif
ifeq ($(wildcard .accesstoken),)
	$(error No .accesstoken file found; create .accesstoken and enter a valid access token)
endif
	curl -X POST \
		-H "api-version: $(IXON_API_VERSION)" \
		-H "api-application: $(IXON_API_APPLICATION_ID)" \
		-H "api-company: $(IXON_API_COMPANY_ID)" \
		-H "authorization: Bearer $(shell cat .accesstoken)" \
		--data-binary @bundle.zip \
		$(IXON_API_BASE_URL)/backend-component-templates/$(IXON_API_TEMPLATE_ID)/version-upload

# Run the ixoncdkingress
run: py-venv-dev
	CBC_PATH=$(CBC_PATH) $(PYTHON_BIN) -m ixoncdkingress
