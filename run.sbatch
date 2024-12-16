#!/bin/bash
#SBATCH --job-name=ragat
#SBATCH -o logs/ragat_out_%j.txt
#SBATCH -e logs/ragat_err_%j.txt
#SBATCH --time=24:00:00
#SBATCH --mem=32G
#SBATCH -c 4
#SBATCH --gres=gpu:1
#SBATCH -p gpu_p
#SBATCH --qos=gpu_normal

# Load Conda environment
CONDA_DIR=/home/icb/hui.cheng/miniconda3
source $CONDA_DIR/etc/profile.d/conda.sh
conda activate ragat

# Print conda environment and installed packages for debugging
echo "Conda environment:"
conda info --envs
echo "Installed packages in ragat environment:"
conda list

# Print Python interpreter path and version
which python
python --version

# Set the working directory
REPO_DIR=/lustre/groups/crna01/workspace/hui/RAGAT
cd $REPO_DIR

# Run the script
python run.py -epoch 1500 -name genfunc -model ragat -score_func \
interacte -opn cross -gpu 0 -data WN18RR -gcn_drop 0.4 -ifeat_drop 0.2 \
-ihid_drop 0.3 -batch 256 -iker_sz 11 -iperm 4 -attention True -head_num 1