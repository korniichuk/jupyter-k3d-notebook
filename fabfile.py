#! /usr/bin/env python2
# -*- coding: utf-8 -*-

"""The jupyter-k3d-notebook stack fabric file"""

from fabric.api import local

def git():
    """Setup Git"""

    local("git remote rm origin")
    local("git remote add origin https://korniichuk@github.com/korniichuk/jupyter-k3d-notebook.git")
    local("git remote add bitbucket https://korniichuk@bitbucket.org/korniichuk/jupyter-k3d-notebook.git")
