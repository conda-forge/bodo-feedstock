set -exo pipefail

export SETUPTOOLS_SCM_PRETEND_VERSION="$PKG_VERSION"

export CONDA_PREFIX_OLD=$CONDA_PREFIX
export CONDA_PREFIX=$PREFIX
export CMAKE_GENERATOR='Ninja'

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "0" ]]; then
    echo "CROSS COMPILING BODO!"
    export SKBUILD_LINK_LIBPYTHON="OFF"
    export PIP_NO_BUILD_ISOLATION=1
    export PIP_NO_INDEX=1
fi

echo "PYTHON executable: $(which python)"
$PYTHON -V
$PYTHON -c "import sys; print(sys.path)"
echo $PYTHONPATH
$PYTHON -c "import numpy; print('NumPy version:', numpy.__version__)"

$PYTHON -m pip install \
    --no-deps --no-build-isolation -vv \
    --config-settings=build.verbose=true \
    --config-settings=logging.level="DEBUG" \
    --config-settings=cmake.args="${CMAKE_ARGS}" \
    .
