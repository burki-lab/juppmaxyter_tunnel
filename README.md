This directory stores codes and files that enable to tunnel jupyter from compute nodes to a local computer.
Therefore, we use a slurm job file, that can be started using an alias.

The procedure is inspired by https://nero-docs.stanford.edu/jupyter-slurm.html .

For the use of this framework, you will need to rund commands on the `SERVER`, as well as on your `LOCAL`computer, which are highlited in the headings to avoid confusions.

## Installation - `SERVER` + `LOCAL`
Clone the repository both, on server and on local computer, using

`git clone https://github.com/burki-lab/juppmaxyter_tunnel.git`

Ensure to have installed (or loaded) JupyterLab on the server.

# Run Jupyter on server 
Follow the next steps to start Jupyterlab on computation nodes of SLURM server.

## Customize the config-file - `SERVER` + `LOCAL`
In `config.yml` you should store your specific configurations on the server, as well as on your local computer.
Set up the file on one of the computation units (e.g. server) and copy its content to the other one (hence, the local computer).

## Start the job on the server - `SERVER`
After configuration, run `src/start_jupy_job.sh` on the server. This will submit a job using your configurations to start JupyterLab on a computation node.

## Wait until job is started ... - `SERVER`
Using `jobinfo -u $USER` you can check, if the job is already started.

## Make the `ssh`-tunnel - `LOCAL`
Now, there should be a running JupyterLab job. We can tunnel it using `src/copy_logs_via_ssh.sh` on the local computer. If you are using a password secure server, you will twice be asked for a password. Before the second prompt you should get a link that you could copy like

`Copy to browser: <LINK>`

## Open JupyterLab in browser - `LOCAL`
Copy the link from before to your favorite browser and enjoy the new Unyverse.

## Terminate JupyterLab - `SERVER`
To save compuation hours always remember to cancel the Jobs and delete the logs. This can be done using `src/cancel_jupyter_jobs.sh`.


# Practicality
To increase the usefullness of `juppmaxyter_tunnel`, one could add aliases to the shell source file (e.g. by using `vim ~/.bashrc` and adding new the alias lines) for fast and simple access:
- `SERVER`:
- - for changing of configs `alias jupchange=vim <ABSPATH_JUPPMAXYTER_TUNNEL_SERVER>/config.yml`
- - for starting jobs `alias jupy=<ABSPATH_JUPPMAXYTER_TUNNEL_SERVER>/src/start_jupy_job.sh`
- - for cancelling all jobs `alias jupterm=<ABSPATH_JUPPMAXYTER_TUNNEL_SERVER>/src/cancel_jupyter_jobs.sh`

- `LOCAL`:
- - for changing of configs `alias jupchange=vim <ABSPATH_JUPPMAXYTER_TUNNEL_LOCAL>/config.yml`
- - for starting the tunnel `alias juptunnel=<ABSPATH_JUPPMAXYTER_TUNNEL_LOCAL>/src/copy_logs_via_ssh.sh`


