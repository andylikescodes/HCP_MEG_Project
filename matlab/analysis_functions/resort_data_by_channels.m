function [resorted_data] = resort_data_by_channels(data, channel_arrangement)

all_channels_str = arrayfun(@(x) ['A', int2str(x)], channel_arrangement, 'un', 0);

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
resorted_trial = cellfun(@(x) x(idx, :), resorted_data.trial, 'un', 0);
resorted_data.trial = resorted_trial;

