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

```bash
mamba env create -f env/python.yaml && \
  mamba run -n python-dev jupyter labextension install jupyterlab-plotly@4.12.0;
mamba env create -f env/git.yaml && \
  mamba run -n git-dev npm install -g markdownlint-cli@0.24.0;
```

#### Create a merged conda environment

```bash
# Merge desired environment files
conda-merge env/python.yaml env/git.yaml | \
  head --lines=-1 | \
  sed -e '$aname: merge-dev' > env/merge.yaml;

# Create and activate environment
mamba env create -f env/merge.yaml && \
  mamba run -n merge-dev jupyter labextension install jupyterlab-plotly@4.12.0 && \
  mamba run -n merge-dev npm install -g markdownlint-cli@0.24.0;
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
