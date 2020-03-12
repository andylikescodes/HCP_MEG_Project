function [coh_stats] = coherence_analysis(data, taper, tapsmofrq, foilim, spatial_filtering, complex)

if ~exist('spatial_filtering', 'var') || isempty(spatial_filtering)
    spatial_filtering = 'no';
else
    cfg = [];
    cfg.method = spatial_filtering;
    cfg.elec = data.grad;
    data = ft_scalpcurrentdensity(cfg, data);
end

if ~exist('complex', 'var') || isempty(complex)
    imaginary = 'no';
end
    
cfg = [];
cfg.output = 'fourier';
cfg.channel = 'all';
cfg.method = 'mtmfft';
cfg.taper = taper;
cfg.tapsmofrq = tapsmofrq;
cfg.foilim = foilim;
cfg.keeptrials = 'yes';
cfg.keeptapers = 'yes';
[mtmfft_freq] = ft_freqanalysis(cfg, data);

cfg = [];
cfg.method = 'coh';
if exist('complex', 'var')
    cfg.complex = complex;
end
[coh_stats] = ft_connectivityanalysis(cfg, mtmfft_freq);



