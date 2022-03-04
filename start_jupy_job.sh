#!/bin/bash
#SBATCH -J jupyter
#SBATCH -A snic2021-5-302
#SBATCH -M rackham
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 08:00:00
#SBATCH -o /proj/uppstore2018069/private/thomas/jupyter_tunnel/jupylog/%A.log
#SBATCH --mail-user thomasmarkus.huber.3696@student.uu.se
#SBATCH --mail-type=NONE

jupyter lab --ip=0.0.0.0 --port=8844 --no-browser
