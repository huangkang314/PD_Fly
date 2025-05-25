function kine_classification(kine_table)

% selected_paras = [13 29 33 34 35 36];
selected_paras = 1:18;
uniqGroup_label = unique(kine_table.group_label);
n_group = length(uniqGroup_label);
% n_paras = size(movement_table.mv_fractions, 2);

kine_matrix = cell2mat(kine_table.frameParas_avg);

% classfication
acu = zeros(n_group, 1);
groupLabels = kine_table.group_label;

kine_matrix = kine_matrix(:, selected_paras);

tx = tall(kine_matrix);
ty = tall(groupLabels);
numObs = gather(length(ty));
rng('default')
tallrng('default')
numTrain = floor(numObs/2);
[txTrain, trIdx] = datasample(tx, numTrain, 'Replace', false);
tyTrain = ty(trIdx);

%     tTree = templateTree('surrogate', 'on');
%     tEnsemble = templateEnsemble('GentleBoost', 100, tTree);
%     options = statset('UseParallel', true);
CVMdl = fitctree(txTrain, tyTrain);

txTest = tx(~trIdx,:);
label = predict(CVMdl, tx);

tyTest = ty;%(~trIdx);
[C, order] = confusionmat(tyTest, label);

cm = confusionchart(tyTest, label);

cm.Title = uniq_stage{isi};
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';

acu(:, isi) = diag(cm.NormalizedValues)./sum(cm.NormalizedValues')';


% creat color scheme
n_genCo = 8;
cclrg = (cbrewer2('Set1', n_genCo));
[X, Y] = meshgrid([1:3], [1:n_group]);
if n_group > n_genCo
    clrg = interp2(X(round(linspace(1, n_group, n_genCo)), :), Y(round(linspace(1, n_group, n_genCo)), :), cclrg, X, Y);
else
    clrg = cclrg(1:n_group, :);
end

fh1 = figure; set(fh1, 'Position', [200, 200, 500, 400])
for ig = 1:n_group
    plot(acu(ig, :), 'Marker', '_', 'Color', clrg(ig, :), 'LineWidth', 3)
    hold on
    
    legend_line{ig} = uniqGroup_label{ig};
    
end


xlabel('Record stages'); ylabel('Accuracy')
hold off; box off
set(gca,'XTick',1:1:n_stage, 'XTickLabel', uniq_stage); xlim([1, n_stage])
l = legend(legend_line,'Orientation','horizontal', 'Location', 'north');
set(l, 'Interpreter', 'none')












