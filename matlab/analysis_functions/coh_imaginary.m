%set up environment
setup;
load_data;

channel_arrangements = [left_channels, right_channels, middle_channels];

resorted_data = resort_data_by_channels(data, channel_arrangements);

stats = coherence_analysis(resorted_data, 'hanning', 2, [0.1 59], [], 'absimag');

save('../output/processed/coh_imaginary.mat','stats');

plotting(stats, 'coh_imaginary/coh_hanning_2_imaginary');
