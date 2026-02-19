set "SETUPTOOLS_SCM_PRETEND_VERSION=%PKG_VERSION%"
set "CONDA_PREFIX=%PREFIX%"
set "BODO_WINDOWS_BUILD_TYPE=Release"

:: Build using pip and CMake
"%PYTHON%" -m pip install . --no-deps --ignore-installed -vv

echo PREFIX=%PREFIX%
dir "%PREFIX%\Lib\site-packages\bodo"
