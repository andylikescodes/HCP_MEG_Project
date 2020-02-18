% Run the setup script
setup

load data/100307_MEG_3-Restin_rmegpreproc.mat

whos


cfg = [];
cfg.hilbert = 'abs';

[hilbert_data] = ft_preprocessing(cfg, data)

plot(hilbert_data.trial{1}(1:100));
saveas(gcf, 'output/hilbert_test1.png');

%cfg = [];
%cfg.method = 'mtmfft';
%cfg.output = 'pow';
%cfg.taper = 'hanning';
%cfg.foi = [12, 30];

%[freq] = ft_freqanalysis(cfg, data)


