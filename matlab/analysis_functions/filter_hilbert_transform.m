setup;
load_data;

channel_arrangements = [left_channels, right_channels, middle_channels];

resorted_data = resort_data_by_channels(data, channel_arrangements);

save_path = '../output/filtered_hilbert/';
name = 'filtered_hilbert_f=';

bands = {[8,15], [16,31], [32,59]}

for i = 1:length(bands)
clf;
f_bands = bands{i};
filename = [save_path, name, int2str(f_bands(1)), '-', int2str(f_bands(2)), '.png'];

cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = bands{i};
cfg.bpfiltord = 5;
cfg.hilbert = 'abs';
hilbert_data = ft_preprocessing(cfg, filtered_data);

cfg = [];
cfg.covariance = 'yes';
cfg.keeptrials = 'yes';
timelock_hilbert = ft_timelockanalysis(cfg, hilbert_data); 

cfg = [];
cfg.method = 'corr';

stats = ft_connectivityanalysis(cfg, timelock_hilbert);

corr = stats.corr;
plot_corr(corr, filename);
end
