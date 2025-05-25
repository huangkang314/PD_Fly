function plot_grouped_mvFractions_lowD(movement_table)

% selected_clus = [1 6 8 9 10 14 24 26 31 33 34 37 39 40];

% selected_clus = {[5, 6], 10, 12, [14, 22], 20, [27, 38], 35, 40};% 1000
% clus_name = {'Sniffing with curling', 'Right turning', 'Sniffing with slow moving', ...
%     'Trotting', 'Climbing', 'Curling', 'Head lowering', 'Grooming'};

uniqGroup_label = unique(movement_table.group_label);
n_group = length(uniqGroup_label);
n_clus = size(movement_table.mv_fractions, 2);
% n_clus = length(selected_clus);

% mvFractions = movement_table.mv_fractions(:, [selected_clus{:}]);
mvFractions = movement_table.mv_fractions;
mv_reduction = tsne(mvFractions, 'Perplexity', 5,...
    'Distance','correlation','NumDimensions', 2);

% mv_reduction = run_umap(mvFractions, 'n_components', 3);

% creat color scheme
n_genCo = 8;
cclrg = (cbrewer2('Set1', n_genCo));
[X, Y] = meshgrid([1:3], [1:n_group]);
if n_group > n_genCo
    clrg = interp2(X(round(linspace(1, n_group, n_genCo)), :), Y(round(linspace(1, n_group, n_genCo)), :), cclrg, X, Y);
else
    clrg = cclrg(1:n_group, :);
end
% clrg(6:end, :) = flipud(clrg(6:end, :));


%%
fh1 = figure;
set(fh1, 'Position', [400, 200, 600, 500])
for isi = 1:n_group
    hold on
    for ig = 1:n_group
        mv_reduction_selected = mv_reduction(strcmp(movement_table.group_label, uniqGroup_label{ig}), :);
        sample_name_selected = movement_table.sample_name(strcmp(movement_table.group_label, uniqGroup_label{ig}));
        
%         scatter3(mv_reduction_selected(:, 1), mv_reduction_selected(:, 2), mv_reduction_selected(:, 3), 80, 'MarkerFaceColor', clrg(ig, :), 'MarkerEdgeColor', 'none');
        scatter(mv_reduction_selected(:, 1), mv_reduction_selected(:, 2), 80, 'MarkerFaceColor', clrg(ig, :), 'MarkerEdgeColor', 'none');
        
%         for it = 1:length(sample_name_selected)
%             text(mv_reduction_selected(it, 1), mv_reduction_selected(it, 2), sample_name_selected(it));
%         end
        
        xlabel('Dim1'); ylabel('Dim2'); %zlabel('Dim3');   
    end
    
end

legend(uniqGroup_label); %view([75 25])
grid on











