# Dev Boilerplate

Boilerplate code to set up my favorite development environments.

## Table of Contents

1. [Repository Contents](https://github.com/ktmeaton/dev-boilerplate#1-repository-contents)
   - [Environments](https://github.com/ktmeaton/dev-boilerplate#1a-environments)
   - [Configuration](https://github.com/ktmeaton/dev-boilerplate#1b-configuration)
   - [Workflows](https://github.com/ktmeaton/dev-boilerplate#1c-workflows)
2. [Setup](https://github.com/ktmeaton/dev-boilerplate#2-setup)

## 1. Repository Contents

### 1a. Environments

```text
📂env
 ┣ 📜 git.yaml
 ┣ 📜 python.yaml
 ┗ 📜 merge.yaml
```

### 1b. Configuration

```text
📂config
 ┣ 📜 vim-setup.sh
 ┣ 📜 .vimrc
 ┣ 📜 zsh-setup.sh
 ┣ 📜 .zshrc
 ┣ 📜 setup.cfg
 ┗ 📜 .pre-commit-config.yaml
```

### 1c. Workflows

```text
📂.github
 ┗📂 workflows
  ┗ 📜 environments.yaml
```

## 2. Setup

Clone repository:

```bash
git clone https://github.com/ktmeaton/dev-boilerplate.git
cd dev-boilerplate
```

### 2a. Environments

#### Install conda

```bash
bash config/conda-setup.sh
conda --version
```

#### Create individual conda environments

General (Required)

```bash
mamba env create -f env/git.yaml && \
  mamba run -n git-dev npm install -g markdownlint-cli@0.24.0;

# Create symlinks to recognize compiler$HOME/miniconda3/envs/git-dev/bin/x86_64-conda_cos6-linux-gnu-gccs
ln -s \
  $HOME/miniconda3/envs/git-dev/bin/x86_64-conda_cos6-linux-gnu-gcc \
  $HOME/miniconda3/envs/git-dev/bin/gcc

ln -s \
  $HOME/miniconda3/envs/git-dev/bin/x86_64-conda_cos6-linux-gnu-g++ \
  $HOME/miniconda3/envs/git-dev/bin/g++
```

Python Development (Optional)

```bash
mamba env create -f env/python.yaml && \
  mamba run -n python-dev jupyter labextension install jupyterlab-plotly@4.12.0;
```

### 2b. Configuration

#### Vim

```bash
conda activate git-dev;
bash config/vim-setup.sh;
```

#### Pre-commit

```bash
conda activate git-dev;
pre-commit install && pre-commit install-hooks;
pre-commit run --all-files;
```

#### Zsh

```bash
conda activate git-dev;
bash config/zsh-setup.sh;
```

#### Grip

On a local computer:

```bash
grip --pass ${GRIP_TOKEN} README.md localhost:8080
```

Over an ssh connection:

```bash
# Connect to the login node
ssh -L 8080:localhost:8080 username@loginnode.com

# Connect to a compute node
ssh -L 8080:localhost:8080 computenode

# Activate the environment
conda activate git-dev

# Start grip server
grip --pass ${GRIP_TOKEN} README.md localhost:8080
