# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
TWINCAT_PROJECT_ROOT ?= ..
TEMPLATE_NAMES ?= $(wildcard $(PWD)/templates/*.rst)
TEMPLATES      ?= $(addprefix --template ,$(TEMPLATE_NAMES))
SPHINXOPTS     ?= --jobs 4
SPHINXBUILD    ?= sphinx-build
SOURCEDIR      = source
BUILDDIR       = build

# Put it first so that "make" without argument is like "make help".
help:
	@command -v $(SPHINXBUILD) > /dev/null 2>&1 || { echo "$(SPHINXBUILD) is required, did you use 'pixi run make html'?"; exit 1; }
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

html: generate

generate:
	@command -v ads-deploy > /dev/null 2>&1 || { echo "ads-deploy is required, did you use 'pixi run make html'?"; exit 1; }
	find "$(TWINCAT_PROJECT_ROOT)" -name *.pixi* -prune -o -type f -iname "*.sln" -print0 \
		| xargs -0 -n1 python -m ads_deploy docs $(TEMPLATES) --output "./source"

clean:
	rm -f source/*.rst
	rm -rf build

.PHONY: generate help Makefile clean

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@command -v $(SPHINXBUILD) > /dev/null 2>&1 || { echo "$(SPHINXBUILD) is required, did you use 'pixi run make html'?"; exit 1; }
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
