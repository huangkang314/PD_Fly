function plot_grouped_kineParas_clusterGram(kine_table)

% selected_clus = [1 6 8 9 10 14 24 26 31 33 34 37 39 40];

% selected_clus = {[5, 6], 10, 12, [14, 22], 20, [27, 38], 35, 40}; %1000
% clus_name = {'Sniffing with curling', 'Right turning', 'Sniffing with slow moving', ...
%     'Trotting', 'Climbing', 'Curling', 'Head lowering', 'Grooming'};

kine_matrix = cell2mat(kine_table.frameParas_avg);
kine_matrix = zscore(kine_matrix, 0);
% mv_reduction = tsne(mvFractions, 'Perplexity',10,...
%     'Distance','correlation','NumDimensions', 3);

cgo = clustergram(kine_matrix, 'Cluster', 'Column', 'RowPDist','correlation');
% set(cgo,'RowLabels', data_3d_gaits.sampleName, 'ColumnLabels', data_3d_gaits.Properties.VariableNames(3:end));
set(cgo,'RowLabels', kine_table.sample_name);
set(cgo,'ColumnLabels', kine_table.frame_paras_name{1}, 'ColumnLabelsRotate', 45);

set(cgo,'Linkage','complete','Dendrogram', 3)
close force


hA = plot(cgo);

set(gcf, 'Position', [400, 200, 600, 500])
set(gca, 'TickLabelInterpreter', 'none')

%     hA.Title.String = uniq_stage{isi};
% end




