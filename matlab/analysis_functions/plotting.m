%%
% A handy function to plot and save analysis
%

function plotting(stats, filename)

if ~exist('filename', 'var') || isempty(filename)
    filename = 'no_input';
else
end

size_sptrm = size(stats.cohspctrm);

lims = [0, 1];

red = [ones(1,256)];
blue = [linspace(1,0,256)];
green = [linspace(1,0,256)];

my_color_map = [red;green;blue]';

for i = 2:size_sptrm(3)
%for i = 2:5
    clf;
    imagesc(stats.cohspctrm(:,:,i), lims);
    colormap(my_color_map);
    colorbar;
    this_filename = [filename, sprintf('_freq=%.4f', stats.freq(i))];
    title(this_filename, 'Interpreter', 'none');
    set(gcf, 'Units', 'Inches', 'Position', [0, 0, 20,16], 'PaperUnits', 'Inches', 'PaperSize', [20,16]);
    if exist('filename', 'var') || ~isempty(filename)
        basepath = '../output'
        this_filename = [this_filename, '.png']
        save_file = fullfile(basepath, this_filename)
        saveas(gcf, save_file)
    end
end
