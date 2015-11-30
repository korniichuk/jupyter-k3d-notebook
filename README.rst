.. contents:: Table of contents
   :depth: 2

Full description
================
The `korniichuk/jupyter-notebook <https://hub.docker.com/r/korniichuk/jupyter-notebook/>`_ Docker image with K3D.

Docker Hub
==========
The `korniichuk/jupyter-k3d-notebook <https://hub.docker.com/r/korniichuk/jupyter-k3d-notebook/>`_ repo.

Quickstart
==========
The following command starts a container with the Notebook server listening for HTTP connections on port 8888 without authentication configured::

    $ docker run -d -p 8888:8888 korniichuk/jupyter-k3d-notebook

Own try.jupyter.org
===================
**First**, the following commands launches a docker container for each user that requests one::

    $ export TOKEN=$( head -c 30 /dev/urandom | xxd -p )
    $ docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN --name=proxy jupyter/configurable-http-proxy --default-target http://127.0.0.1:9999
    $ docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=$TOKEN -v /var/run/docker.sock:/docker.sock jupyter/tmpnb python orchestrate.py --image='korniichuk/jupyter-k3d-notebook' --command="ipython notebook --NotebookApp.base_url={base_path} --ip=0.0.0.0 --port {port}"

**Second**, visit your host on port 8000.

User guide
==========
Users
-----
You can start a container with ``root`` user::

    $ docker run -u root -d -p 8888:8888 korniichuk/jupyter-k3d-notebook

or::

    $ docker run --user root -d -p 8888:8888 korniichuk/jupyter-k3d-notebook

Where:

 * ``-u`` or ``--user`` -- username or UID (format: <name|uid>[:<group|gid>]).
