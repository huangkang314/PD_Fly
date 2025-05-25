function plot_DLC_quality(behavior_data_table)

n_sample = size(behavior_data_table, 1);


for id = 1:n_sample
    temTag = ['Intra-', num2str(id)];
    temData = mean(behavior_data_table.data2dllh{id}');
    vlIntra(id) = Violin(temData, 3*id-0.5, 'ViolinColor', [1 0 0], 'Width', 0.8, 'ShowMean', true, 'BoxColor', [.3, 0.3, .3]);

end