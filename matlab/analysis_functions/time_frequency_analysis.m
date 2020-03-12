setup;
load_data;

channel_arrangements = [left_channels, right_channels, middle_channels];

resorted_data = resort_data_by_channels(data, channel_arrangements);

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
base_path = '../output/time_frequency_plots/';
for i = 1:length(resorted_data.label)
    clf;
    cfg.channel = resorted_data.label{i};
    ft_singleplotTFR(cfg, mtmconvol_freq);
    file_path = [base_path, 'mtmconvol_hanning_', cfg.channel, '.png'];
    saveas(gcf, file_path);
end


