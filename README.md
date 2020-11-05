# dev-boilerplate

Boilerplate code to set up my favorite development environments.

## Table of Contents

1. Repository Contents
   - Environments
   - Configuration
   - Workflows
2. Setup

## 1. Repository Contents

### Environments (env)

- conda environments:
  - conda
  - python
  - git
  - markdown

### Configuration (config)

- vim
  - vim-setup.sh
  - .vimrc
- zsh
  - zsh-setup.sh
  - .zshrc
- bash
  - .bashrc
- .pre-commit-config.yaml
- setup.cfg

### Workflows (.github/workflows)

- env

## 2. Setup

### Environments

Create individual conda environments.

```bash
conda env create -f env/conda.yaml
conda env create -f env/python.yaml;
conda env create -f env/git.yaml;
conda run -n git-dev npm install -g markdownlint-cli@0.24.0
```

Create a merged conda environment.

```bash
# Create the conda-dev environment to access to conda-merge and mamba.
conda env create -f env/conda.yaml;
conda activate conda-dev;

# Merge desired environment files
conda-merge \
  env/python.yaml \
  env/git.yaml \
  env/conda.yaml | \
  head --lines=-1 | \
  sed -e '$aname: merge-dev' \
  > env/merge.yaml

# Create and activate environment
mamba env create -f env/merge.yaml;
conda run -n merge-dev npm install -g markdownlint-cli@0.24.0
```

### Configuration

Vim

```bash
conda activate git-dev;
config/vim-setup.sh;
```

Pre-commit

```bash
conda activate git-dev;
pre-commit install;
pre-commit install-hooks;
pre-commit run --all-files;
```
