set -exo pipefail

export SETUPTOOLS_SCM_PRETEND_VERSION="$PKG_VERSION"

export CONDA_PREFIX_OLD=$CONDA_PREFIX
export CONDA_PREFIX=$PREFIX
export CMAKE_GENERATOR='Ninja'

ls $SP_DIR/numpy/_core

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "0" ]]; then
    # export NUMPY_INCLUDE_DIR="$SP_DIR/numpy/_core/include"
    # export PIP_EXTRA_CONFIG="--config-settings=cmake.define.Python_NumPy_INCLUDE_DIR="${NUMPY_INCLUDE_DIR}""
    $PYTHON -m pip install "numpy>=1.26"
fi

$PYTHON -m pip install \
    --no-deps --no-build-isolation -vv \
    --config-settings=build.verbose=true \
    --config-settings=logging.level="DEBUG" \
    --config-settings=cmake.args="${CMAKE_ARGS}" \
    $PIP_EXTRA_CONFIG .
