clear;
clc;
clf;
% Run the setup script
setup;

load data/100307_MEG_3-Restin_rmegpreproc.mat;


middle_channels = [121, 89, 61,37, 19, 5, 4, 3, 2, 1, 12, 28, 49, 75, 105, 137, 186, 220];
left_channels = [122, 90, 123, 62, 91, 124, 38, 63, 92, 20, 39, 64, 93, 125, 153, 177, 212, 229, 6, 21, 40, 65, 94, 126, 154, 178, 7, 22, 41, 66, 95, 127, 155, 179, 213, 230, 8, 23, 42, 67, 96, 128, 156, 196, 231, 9, 24, 43, 68, 97, 129, 157, 197, 232, 10, 25, 44, 69, 98, 130, 158, 198, 233, 11, 26, 45, 70, 99, 131, 180, 214, 27, 46, 71, 100, 132, 159, 48, 47, 72, 101, 74, 73, 102, 133, 160, 181, 104, 103, 134, 161, 182, 199, 215, 136, 135, 162, 183, 200, 216, 234, 164, 163, 184, 201, 217, 235, 185, 202, 218, 236, 203, 219, 237, 238];
right_channels = [152, 120, 151, 88, 119, 150, 60, 87, 118, 36, 59, 86, 117, 149, 176, 195, 228, 248, 18, 35, 58, 85, 116, 148, 175, 194, 17, 34, 57, 84, 115, 147, 174, 193, 227, 247, 16, 33, 56, 83, 114, 146, 173, 211, 246, 15, 32, 55, 82, 113, 145, 172, 210, 245, 14, 31, 54, 81, 112, 144, 171, 209, 244, 13, 30, 53, 80, 111, 143, 192, 226, 29, 52, 79, 110, 142, 170, 50, 51, 78, 109, 76, 77, 108, 141, 169, 191, 106, 107, 140, 168, 190, 208, 225, 138, 139, 167, 189, 207, 224, 243, 165, 166, 188, 206, 223, 242, 187, 205, 222, 241, 204, 221, 240, 239];

all_channels = [left_channels, right_channels, middle_channels];

all_channels_str = arrayfun(@(x) ['A', int2str(x)], all_channels, 'un', 0);

index = [];
for i = 1:length(all_channels_str)
    if ~any(cellfun(@isequal, data.label, repmat({all_channels_str{i}}, size(data.label))))
        index = [index, i];
    end
end

all_channels_str(index) = [];

[tf, idx] = ismember(all_channels_str, data.label);
resorted_label = data.label(idx);

resorted_data = data;

resorted_data.label = resorted_label;
resorted_trial = cellfun(@(x) x(idx,:), resorted_data.trial, 'un', 0);
resorted_data.trial = resorted_trial;

whos;

cfg = [];
cfg.bpfreq = [8, 15];
cfg.bpfilter = 'yes';

filter_data = ft_preprocessing(cfg, resorted_data);

cfg = [];
%cfg.bpfilter = [50];
cfg.hilbert = 'abs';
[hilbert_data] = ft_preprocessing(cfg, filter_data);

%cfg = [];
%cfg.bpfilter = [50];
%cfg.hilbert = 'angle';

%[angle] = ft_preprocessing(cfg, data);

%plot(hilbert_data.trial{1}(1:100));
%hold on;
%plot(filter_data.trial{1}(1:100));
%hold on;
%plot(angle.trial{1}(1:100));

%plot([1,0], [0,1])

%saveas(gcf, 'output/hilbert_test1.png');




% Frequency analysis;
cfg = [];
cfg.output = 'fourier';
cfg.channel = 'all';
cfg.method = 'mtmfft';
cfg.taper = 'hanning';
cfg.tapsmofrq = 2;
cfg.foilim = [8, 15];
cfg.keeptrials = 'yes';
cfg.keeptapers = 'yes';
[mtmfft_freq] = ft_freqanalysis(cfg, filter_data);


%cfg = [];
%cfg.output = 'fourier';
%cfg.channel = 'all';
%cfg.method = 'mtmconvol';
%cfg.taper = 'hanning';
%cfg.tapsmofrq = 2;
%cfg.foi = 8:0.5:15;
%cfg.t_ftimwin = 7./cfg.foi;
%cfg.toi = 'all';
%cfg.keeptrials = 'no';
%cfg.keeptapers = 'no';
%[mtmconvol_freq] = ft_freqanalysis(cfg, filter_data);



% Do some connectivity analysis
cfg = [];
cfg.method = 'coh';
[mtmfft_stats] = ft_connectivityanalysis(cfg, mtmfft_freq);
%[mtmconvol_stats] = ft_connectivityanalysis(cfg, mtmconvol_freq);

size_sptrm = size(mtmfft_stats.cohspctrm);
%for i = 1:size_sptrm(3)
%    subplot(3,5,i);
%    heatmap(mtmfft_stats.cohspctrm(:,:,i));
%end

lims = [-1,1]

imagesc(mtmfft_stats.cohspctrm(:,:,1), lims);

red = [linspace(1,0,128), zeros(1, 128)];
blue = [zeros(1, 128), linspace(0,1,128)];
green = [zeros(1,256)];

myColorMap = [red;blue;green]';

colormap(myColorMap);
colorbar;

saveas(gcf, 'output/coherence_image.png');

%cfg = [];
%cfg.method = 'coh';
%coh_stats = ft_connectivityanalysis(cfg, freq);

%cfg = [];
%cfg.method = '';

%cfg = [];
%cfg.method = 'corr';
%stats = ft_connectivityanalysis(cfg, data);
%cfg = [];
%cfg.method = 'mtmfft';
%cfg.output = 'pow';
%cfg.taper = 'hanning';
%cfg.foi = [12, 30];

%[freq] = ft_freqanalysis(cfg, data)


