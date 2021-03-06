### * Variables

PYTHON_MODULE=pydep
PYTHON_MODULE_EGG=$(PYTHON_MODULE).egg-info

COVERED_PACKAGES=$(PYTHON_MODULE)
SPHINX_DOC_FOLDER=docs/

# ### ** Main script
# PYTHON=python
# MODULE_NAME=pydep
# MYSCRIPT_NOPY=pydep
# MYSCRIPT=$(MODULE_NAME)/$(MYSCRIPT_NOPY).py

# ### ** Tests
# TEST_DIR=tests
# TEST_SCRIPT=tests.py

# ### ** Examples
# EXAMPLE_MOD_NOPY=exampleModule

### * Help

Help:
	@echo "Makefile for the $(PYTHON_MODULE) Python module                   "
	@echo "                                                                  "
	@echo "Type: \"make <target>\" where <target> is one of the following:   "
	@echo "                                                                  "
	@echo "  test             Run the tests with coverage output             "
	@echo "  doc              Run Sphinx to make the docs                    "
	@echo "  clean            Remove generated doc, tests and pyc files      "
	@echo "                                                                  "
	@echo "You need sudo rights for the following ones:                      "
	@echo "                                                                  "
	@echo "  install          Install the module and command-line tools      "
	@echo "  uninstall        Uninstall the module                           "
	# @echo "  examples            Run basic examples                        "
	# @echo "  doc_examples        Run doc examples                          "
	# @echo "  test                Run tests                                 "
	# @echo ""
	# @echo "  install             Run pip install -e  (must be sudo)        "
	# @echo "  uninstall           Remove the package (must be sudo)         "
	# @echo ""
	# @echo "  clean               Clean everything except the egg info      "
	# @echo "  clean_egg           Clean egg info folder (must be sudo)      "
	# @echo "  doc_clean           Clean doc examples                        "

### * Main targets

### ** test
tests: test
test:
	nosetests tests/ --with-coverage --cover-package=$(COVERED_PACKAGES) --cover-html \
	  --with-html --html-file=tests/nosetests.html
	@echo -e "\nThe coverage results are accessible from cover/index.html"
	@echo "The html version of the test results are accessible from tests/nosetests.html"

### ** doc
docs: doc
doc:
	sphinx-apidoc -o $(SPHINX_DOC_FOLDER) ./ setup.py
	cd $(SPHINX_DOC_FOLDER); make html
	@echo -e "\nThe documentation is accessible from $(SPHINX_DOC_FOLDER)_build/html/index.html"

### ** clean
clean:
	rm -f .coverage
	rm -fr cover
	rm -f tests/nosetests.html
	rm -fr docs/_build
	find . -name \*.pyc -type f -delete

### ** install
install:
	rm -fr $(PYTHON_MODULE_EGG)
	pip install -e .

### ** uninstall
uninstall:
	pip uninstall -y $(PYTHON_MODULE)

# ### ** examples
# examples:
# 	# Local graph of the pydep module
# 	$(PYTHON) $(MYSCRIPT) $(MYSCRIPT)
# 	dot -Tpdf $(MYSCRIPT_NOPY).graph.dot -o $(MYSCRIPT_NOPY).local.graph.pdf
# 	# Global graph of the pydep module
# 	$(PYTHON) $(MYSCRIPT) $(MYSCRIPT) --all
# 	dot -Tpdf $(MYSCRIPT_NOPY).graph.dot -o $(MYSCRIPT_NOPY).global.graph.pdf
# 	# Local graph of simple example module
# 	$(PYTHON) $(MYSCRIPT) $(TEST_DIR)/$(EXAMPLE_MOD_NOPY).py
# 	dot -Tpdf $(EXAMPLE_MOD_NOPY).graph.dot -o $(EXAMPLE_MOD_NOPY).graph.pdf

# ### ** doc_examples
# doc_examples: doc_clean
# 	# Local graph of the pydep module
# 	$(PYTHON) $(MYSCRIPT) $(MYSCRIPT)
# 	dot -Tpng $(MYSCRIPT_NOPY).graph.dot -o $(MYSCRIPT_NOPY).local.graph.png
# 	mv $(MYSCRIPT_NOPY).graph.dot doc_examples/$(MYSCRIPT_NOPY).local.graph.dot
# 	# Global graph of the pydep module
# 	$(PYTHON) $(MYSCRIPT) $(MYSCRIPT) --all
# 	dot -Tpng $(MYSCRIPT_NOPY).graph.dot -o $(MYSCRIPT_NOPY).global.graph.png
# 	mv $(MYSCRIPT_NOPY).graph.dot doc_examples/$(MYSCRIPT_NOPY).global.graph.dot
# 	# Local graph of simple example module
# 	$(PYTHON) $(MYSCRIPT) $(TEST_DIR)/$(EXAMPLE_MOD_NOPY).py
# 	dot -Tpng $(EXAMPLE_MOD_NOPY).graph.dot -o $(EXAMPLE_MOD_NOPY).graph.png
# 	mv $(EXAMPLE_MOD_NOPY).graph.dot doc_examples/
# 	# Move the output to doc_examples
# 	mv $(MYSCRIPT_NOPY).local.graph.png $(MYSCRIPT_NOPY).global.graph.png \
# 	  $(EXAMPLE_MOD_NOPY).graph.png doc_examples/

# ### ** test
# test:
# 	nosetests $(TEST_SCRIPT) --with-coverage --cover-package=$(MYSCRIPT_NOPY) --cover-html
# 	@echo -e "\nThe coverage results are accessible from cover/index.html"

# tests: test

# ### ** install
# install:
# 	pip install -e .

# ### ** uninstall
# uninstall:
# 	pip uninstall -y $(MODULE_NAME)

# ### ** clean
# clean: doc_clean
# 	# pyc files
# 	rm -f *.pyc tests/*.pyc pydep/*.pyc
# 	# Coverage files
# 	rm -f .coverage
# 	rm -fr cover
# 	# Example files
# 	rm -f $(MYSCRIPT_NOPY).graph.dot
# 	rm -f $(MYSCRIPT_NOPY).local.graph.pdf
# 	rm -f $(MYSCRIPT_NOPY).global.graph.pdf
# 	rm -f $(EXAMPLE_MOD_NOPY).graph.dot
# 	rm -f $(EXAMPLE_MOD_NOPY).graph.pdf

# clean_egg:
# 	rm -fr $(MODULE_NAME).egg-info

# doc_clean:
# 	rm -f doc_examples/*
