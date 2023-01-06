# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
TWINCAT_PROJECT_ROOT ?= ..
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = build

html: generate

generate:
	if ! command -v ads-deploy 2>/dev/null; then \
		echo "ads-deploy not found; installing requirements."; \
		python -m pip install -r requirements.txt; \
	fi
	find "$(TWINCAT_PROJECT_ROOT)" -type f -iname "*.sln" -print0 \
		| xargs -0 -n1 python -m ads_deploy docs --output "./source"

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: generate help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
