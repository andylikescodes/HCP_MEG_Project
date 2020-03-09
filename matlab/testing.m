% Run the setup script
setup;
load_data;

channel_arrangments = [left_channels, right_channels, middle_channels];

resorted_data = resort_data_by_channels(data, channel_arrangments);

% Frequency analysis;
cfg = [];
cfg.output = 'pow';
cfg.channel = 'all';
cfg.method = 'mtmconvol';
cfg.taper = 'hanning';
cfg.foi = 1:0.5:59;
cfg.toi = 'all'
%cfg.t_ftimwin = ones(size(cfg.foi)) * 0.5;
cfg.t_ftimwin = 7./cfg.foi;

[mtmconvol_freq] = ft_freqanalysis(cfg, resorted_data);


cfg = [];
cfg.channel = 'A122'
ft_singleplotTFR(cfg, mtmconvol_freq);

saveas(gcf, 'output/testing/testing_mtmconvol_freq.png');

