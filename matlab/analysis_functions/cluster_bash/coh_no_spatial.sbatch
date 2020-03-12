#!/bin/env bash

#SBATCH --job-name=coh_no_spatial
#SBATCH --output=coh_no_spatial.out
#SBATCH --error=coh_no_spatial.err
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32768
#SBATCH --ntasks=1

module load matlab
matlab -nodisplay -nosplash < ../coh_no_spatial.m
