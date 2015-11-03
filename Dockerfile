# Jupyter Notebook with K3D
# jupyter/minimal-notebook with ipywidgets, K3D, matplotlib, NumPy, SciPy.

FROM jupyter/minimal-notebook:latest

MAINTAINER Ruslan Korniichuk <ruslan.korniichuk@gmail.com>

# Now switch to jovyan for all conda installs
USER jovyan

# Install ipywidgets, matplotlib, NumPy, SciPy for Python 3
RUN conda install --yes ipywidgets matplotlib numpy scipy && conda clean -yt

# Install ipywidgets, matplotlib, NumPy, SciPy for Python 2
RUN conda create -p $CONDA_DIR/envs/python2 python=2.7 \
    ipython ipywidgets matplotlib numpy scipy \
    && conda clean -yt

USER root

# Install Python 2 kernel spec globally to avoid permission problems when
# NB_UID switching at runtime.
RUN $CONDA_DIR/envs/python2/bin/python \
    $CONDA_DIR/envs/python2/bin/ipython \
    kernelspec install-self
