{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  pylint,
  dataclasses-json,
  tomli,
  requests,
  platformdirs,
  loguru,
  flake8,
  callPackage,
}:
buildPythonPackage rec {
  pname = "edulint";
  version = "4.2.2";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-HghX6OBG+r2rJQUspnJHWZicnjZCgDk8MxoWaxAABjA=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    # wheel
  ];
  dependencies = [
    flake8
    (callPackage ./flake8_json.nix {})
    pylint
    dataclasses-json
    tomli
    requests
    platformdirs
    loguru
  ];

  pythonRelaxDeps = true;
}
