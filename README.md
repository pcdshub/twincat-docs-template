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

### Templates

Templates are vendored from ads-deploy in this repository in ``templates/``.

These are in Jinja2-compatible markdown syntax and are interpolated by
``ads-deploy docs`` (``pytmc template``).

Filenames may contain Jinja syntax well, making an easy way for multiple
projects/PLCs/etc to be contained in the same documentation repository.

Details on available filters and variables may be found in
``ads-deploy`` and ``pytmc``:

1. [ads-deploy docs](https://github.com/pcdshub/ads-deploy/blob/master/ads_deploy/docs.py)
2. [pytmc template](https://github.com/pcdshub/pytmc/blob/master/pytmc/bin/template.py)
2. [pytmc parser](https://github.com/pcdshub/pytmc/blob/master/pytmc/parser.py)


## Example

Examples of documentation generated from this repository:
1. [lcls-plc-rixs-optics](https://pcdshub.github.io/lcls-plc-rixs-optics), a PLC project
2. [lcls-twincat-general](https://pcdshub.github.io/lcls-twincat-general/), a PLC library
