set -exo pipefail

export SETUPTOOLS_SCM_PRETEND_VERSION="$PKG_VERSION"

export CONDA_PREFIX_OLD=$CONDA_PREFIX
export CONDA_PREFIX=$PREFIX
export CMAKE_GENERATOR='Ninja'

$PYTHON -m pip install \
    --no-deps --no-build-isolation -vv \
    --config-settings=build.verbose=true \
    --config-settings=logging.level="DEBUG" \
    --config-settings=cmake.args="${CMAKE_ARGS}"
