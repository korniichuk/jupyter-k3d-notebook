# Version: 0.1b2
# Jupyter Notebook with K3D
# The jupyter/minimal-notebook Docker image with ipywidgets, K3D, matplotlib,
# NumPy, SciPy.

FROM jupyter/minimal-notebook:latest

MAINTAINER Ruslan Korniichuk <ruslan.korniichuk@gmail.com>

# Now switch to jovyan for all conda installs
USER jovyan

# Install ipywidgets, matplotlib, NumPy, SciPy for Python 3
RUN conda install --yes \
    ipywidgets matplotlib numpy scipy \
    && conda clean -yt

# Install ipywidgets, matplotlib, NumPy, SciPy for Python 2
RUN conda create -p $CONDA_DIR/envs/python2 \
    python=2.7 ipywidgets matplotlib numpy scipy \
    && conda clean -yt

USER root

# Clone K3D repository
RUN git clone https://github.com/K3D-tools/K3D-jupyter.git

# Install npm for bower installation
RUN apt-get install -y npm

# Make an alias
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Install bower for K3D installation
RUN npm install -g bower

# Install K3D for Python 3
RUN cd K3D-jupyter && bower install --allow-root --config.interactive=false \
    && pip install .

# Install K3D for Python 2
RUN cd K3D-jupyter && /opt/conda/envs/python2/bin/pip install .

# Install Python 2 kernel spec globally to avoid permission problems when
# NB_UID switching at runtime.
RUN $CONDA_DIR/envs/python2/bin/python \
    $CONDA_DIR/envs/python2/bin/ipython \
    kernelspec install-self

# Copy /home/jovyan/work/K3D-jupyter/examples dir to /home/jovyan/work dir
RUN cp -a /home/jovyan/work/K3D-jupyter/examples /home/jovyan/work

# Change the owner of /home/jovyan/work/examples dir to jovyan (recursively)
RUN chown -R jovyan /home/jovyan/work/examples

# Delete K3D-jupyter dir
RUN rm -r /home/jovyan/work/K3D-jupyter
