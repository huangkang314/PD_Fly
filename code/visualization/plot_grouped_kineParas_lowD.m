function plot_grouped_kineParas_lowD(kine_table)

uniqGroup_label = unique(kine_table.group_label);
n_group = length(uniqGroup_label);
% n_paras = size(movement_table.mv_fractions, 2);

% kine_matrix = [table2array(kine_table.frameParas_avg), table2array(kine_table.gaitParas_avg)];

kine_matrix = cell2mat(kine_table.frameParas_avg);

% kine_matrix = kine_matrix(:, 1:20);
kine_reduction = tsne(kine_matrix, 'Perplexity', 4,...
    'Distance','correlation','NumDimensions', 2);

% kine_reduction = run_umap(kine_matrix, 'n_components', 3, 'verbose', 'text');

% kine_matrix = zscore(kine_matrix, 0);
paras_name = kine_table.frame_paras_name{1};
n_paras = size(kine_matrix, 2);

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

fh1 = figure;
set(fh1, 'Position', [400, 200, 600, 500])
for isi = 1:n_group
    hold on
    for ig = 1:n_group
        kine_reduction_selected = kine_reduction(strcmp(kine_table.group_label, uniqGroup_label{ig}), :);
        sample_name_selected = kine_table.sample_name(strcmp(kine_table.group_label, uniqGroup_label{ig}));
%         scatter3(kine_reduction_selected(:, 1), kine_reduction_selected(:, 2), kine_reduction_selected(:, 3), 80,...
%             'MarkerFaceColor', clrg(ig, :), 'MarkerEdgeColor', 'none');
        
        scatter(kine_reduction_selected(:, 1), kine_reduction_selected(:, 2), 80,...
            'MarkerFaceColor', clrg(ig, :), 'MarkerEdgeColor', 'none');
        
%         for it = 1:length(sample_name_selected)
%             text(kine_reduction_selected(it, 1), kine_reduction_selected(it, 2), sample_name_selected(it));
%         end
        
        
    end
    
end
xlabel('Dim1'); ylabel('Dim2'); zlabel('Dim3');
legend(uniqGroup_label); %view([75 25])
grid on












