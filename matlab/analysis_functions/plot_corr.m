function plot_corr(corr, save_path)

if ~exist('save_path','var') || isempty(save_path)
    filename = 'save_path';
else
end

lims = [0, 1];

red = [ones(1,256)];
blue = [linspace(1,0,256)];
green = [linspace(1,0,256)];

my_color_map = [red;green;blue]';

[path, name, ext] = fileparts(save_path);

imagesc(corr);
colormap(my_color_map);
colorbar;
title(name, 'Interpreter', 'none');

if exist('save_path', 'var')
    set(gcf, 'Units', 'Inches', 'Position', [0,0,20,16], 'PaperUnits', 'Inches', 'PaperSize', [20,16]);
    saveas(gcf, save_path);
end
