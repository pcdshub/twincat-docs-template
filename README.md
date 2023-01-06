## TwinCAT Documentation Template

This project is intended to be used from PCDS's CI scripts, but it may be used
standalone as well.

### How this works

The make target ``html`` has been reconfigured to generate documentation
first with ``ads-deploy``.

``ads-deploy`` will automatically be installed in the current Python
environment if it is unavailable, along with other requirements found in
[requirements.txt](/requirements.txt) in this repository.

```bash
$ make html
# Installs requirements.txt if ads-deploy not found
# Generates source/*.rst with solutions from TWINCAT_PROJECT_ROOT
# Builds build/html
```

By default, TWINCAT_PROJECT_ROOT is `..`. This means that the documentation
template is expected to be cloned *inside* the top level of the PLC project.

### As a submodule

This could be used as a submodule in repositories:

```
$ git submodule add https://github.com/pcdshub/twincat-docs-template docs
$ git commit -am "DOC: install documentation template as a submodule"
$ cd docs/
$ make html
```
