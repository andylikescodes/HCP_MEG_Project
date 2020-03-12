#!/bin/env bash

#SBATCH --job-name=coh_spline
#SBATCH --output=coh_spline.out
#SBATCH --error=coh_spline.err
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32768
#SBATCH --ntasks=1

module load matlab
matlab -nodisplay -nosplash < ../coh_spline.m
