function plot_grouped_mvFractions_clusterGram(movement_table)

% selected_clus = [1 6 8 9 10 14 24 26 31 33 34 37 39 40];

% selected_clus = {[5, 6], 10, 12, [14, 22], 20, [27, 38], 35, 40}; %1000
% clus_name = {'Sniffing with curling', 'Right turning', 'Sniffing with slow moving', ...
%     'Trotting', 'Climbing', 'Curling', 'Head lowering', 'Grooming'};

% mvFractions = movement_table.mv_fractions(:, [selected_clus{:}]);
mvFractions = zscore(movement_table.mv_fractions);
% mv_reduction = tsne(mvFractions, 'Perplexity',10,...
%     'Distance','correlation','NumDimensions', 3);

cgo = clustergram(mvFractions, 'Cluster', 'Column', 'RowPDist','correlation');
% set(cgo,'RowLabels', data_3d_gaits.sampleName, 'ColumnLabels', data_3d_gaits.Properties.VariableNames(3:end));
set(cgo,'RowLabels', movement_table.sample_name);

set(cgo,'Linkage','complete','Dendrogram', 3)
close force

hA = plot(cgo);
%     hA.Title.String = uniq_stage{isi};
% end




