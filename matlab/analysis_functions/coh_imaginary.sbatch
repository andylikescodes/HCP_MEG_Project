#!/bin/env bash

#SBATCH --job-name=coh_imaginary
#SBATCH --output=cluster_bash/coh_imaginary.out
#SBATCH --error=cluster_bash/coh_imaginary.err
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32768
#SBATCH --ntasks=1

module load matlab
matlab -nodisplay -nosplash < coh_imaginary.m
