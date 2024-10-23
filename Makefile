VENV = .venv
REQUIREMENTS = requirements.txt

PYTHON = $(VENV)/bin/python
PIP = $(VENV)/bin/pip

.PHONY: all
all: run

$(VENV)/bin/activate: 
	python3 -m venv $(VENV)

.PHONY: install
install: $(VENV)/bin/activate
	$(PIP) install -r $(REQUIREMENTS)

.PHONY: run
run: $(VENV)/bin/activate
	$(PYTHON) pymake/main.py $(RUN_ARGS)

.PHONY: clean
clean:
	rm -rf $(VENV)
	find . -name "*.pyc" -exec rm -f {} \;
	find . -name "__pycache__" -exec rm -rf {} \;
	find . -name ".pytest_cache" -exec rm -rf {} \;

.PHONY: test
test: $(VENV)/bin/activate
	$(VENV)/bin/pytest -vvs --color=yes --log-cli-level=debug $(PYTEST_ARGS)

.PHONY: build
build: setup.py
	python3 setup.py build bdist_wheel

.PHONY: clean-build
clean-build:
	rm -rf build dist *.egg-info