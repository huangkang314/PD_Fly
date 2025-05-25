function mvFractions_grouped = plot_grouped_mvFractions_onlyBoxplot(movement_table)

uniqGroup_label = unique(movement_table.group_label);
n_group = length(uniqGroup_label);
n_clus = size(movement_table.mv_fractions, 2);
legend_label = cell(n_group, 1);

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

makers = {'d', '^', 'o', '+', 's', 'p', 'v', '>', 'h', '<', 'x'};
fh1 = figure;
set(fh1, 'Position', [200, 200, 1200, 400])
fh2 = figure;
set(fh2, 'Position', [200, 200, 1200, 400])
mvMean_group = zeros(n_group, n_clus);
boxPlot_data_all = [];
colors = [];
hold on

for ig = 1:n_group
    group_selected = movement_table(strcmp(movement_table.group_label, uniqGroup_label{ig}), :);
    mvFractions = group_selected.mv_fractions;
    mvMean = mean(mvFractions);
    mvStderr = std(mvFractions, 0, 1) / sqrt(size(mvFractions, 1));
    mvStderrvals = [mvMean + mvStderr, mvMean(end:-1:1) - mvStderr(end:-1:1)];
    
    mvMean_group(ig, :) = mvMean;
    
    % box plot data
    n_sample = size(mvFractions, 1);
    boxPlot_data = zeros(n_sample*n_clus, 4);
    figure(fh1);
    hold on
    for isa = 1:n_sample
        boxPlot_data((isa-1)*n_clus+1 : isa*n_clus, 1) = ig*ones(1, n_clus);
        boxPlot_data((isa-1)*n_clus+1 : isa*n_clus, 2) = (1:n_clus)+1/(n_group+1)*(ig-0.5);
        boxPlot_data((isa-1)*n_clus+1 : isa*n_clus, 3) = mvFractions(isa, :);
        boxPlot_data((isa-1)*n_clus+1 : isa*n_clus, 4) = (1:n_clus);
        plot(1:n_clus, mvFractions(isa, :), makers{ig}, 'Color', [clrg(ig, :), 0.4], 'MarkerSize', 1, 'LineWidth', 1)
    end
    
    plot_avgerr(mvFractions, clrg(ig, :), 1);
    %     plot(1:n_clus,  mvMean, 's-', 'Color', [clrg(6, :), 0.4], 'MarkerSize', 3)
    
    figure(fh2);
    color = repmat(clrg(ig, :), n_sample*n_clus, 1);
%     boxplot(boxPlot_data(:, 3), boxPlot_data(:, 2), 'Colors', clrg(ig, :), 'BoxStyle', 'outline', ...
%         'Positions', boxPlot_data(:, 2), 'Widths', 1/(n_group+2), 'OutlierSize', 0.1);
    h = boxchart(boxPlot_data(:,2), boxPlot_data(:,3), 'GroupByColor',...
        boxPlot_data(:,1), 'JitterOutliers','off', 'MarkerStyle', '.', 'BoxWidth', 1/(n_group+2));
    
    h.BoxFaceColor = clrg(ig, :);
    h.MarkerColor = clrg(ig, :);
    legend_label{ig, 1} = uniqGroup_label{ig};
%     legend_label{ig*2, 1} = '';

    hold on
    scatter(boxPlot_data(:, 2)+(rand(size(boxPlot_data(:, 3)))-0.5)/(n_group+2), ...
        boxPlot_data(:, 3), 5*ones(length(boxPlot_data(:, 2)), 1), color, 'filled', makers{ig}, 'HandleVisibility','off')
    
    boxPlot_data_all = [boxPlot_data_all; boxPlot_data];
    colors = [colors; repmat(clrg(ig, :), n_sample*n_clus, 1)];
    
    eval(['mvFractions_grouped.', uniqGroup_label{ig}, '= transpose(mvFractions);'])
    
end

%% 2-way anova
% for ic = 1:n_clus
%     tem_clusData = boxPlot_data_all(boxPlot_data_all(:, 4) == ic, :);
%     goup_array = cell(1, n_group);
%     for ig = 1:n_group
%         goup_array(:, ig) = {double(tem_clusData(:, 1) == ig)};
%     end
%     %     stats = anovan(tem_clusData(:, 3), goup_array, 'model', 1, 'varnames', uniqGroup_label)
%     [~, ~, stats] = anova1(tem_clusData(:, 3), tem_clusData(:, 1), [],'off');
%     [c, ~, ~, ~] = multcompare(stats, 'display', 'off');
%     close force
%     close force
%     tbl1 = array2table(c,"VariableNames", ...
%         ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"]);
%     figure(fh2)
%     for igr = 1:n_group
%         for igt = 2:n_group
%             if c(c(:, 1) == igr & c(:, 2) == igt, 6) < 0.05
%                 start = tem_clusData(find(tem_clusData(:, 1) == igr, 1, 'First'), 2);
%                 stop = tem_clusData(find(tem_clusData(:, 1) == igt, 1, 'First'), 2);
%                 plot([start, stop], [max(boxPlot_data_all(:, 3)), max(boxPlot_data_all(:, 3))], 'k', 'LineWidth', 1)
%                 if c(c(:, 1) == igr & c(:, 2) == igt, 6) < 0.001
%                     text((start+stop)/2, max(boxPlot_data_all(:, 3)), '***')
%                 elseif c(c(:, 1) == igr & c(:, 2) == igt, 6) < 0.01
%                     text((start+stop)/2, max(boxPlot_data_all(:, 3)), '**')
%                 else
%                     text((start+stop)/2, max(boxPlot_data_all(:, 3)), '*')
%                 end
%             end
%         end
%         
%     end
%     
% end


figure(fh1)
xlabel('Movement types'); ylabel('Movement fractions')
set(gca,'XTick', 1:n_clus, 'XTickLabel', 1:n_clus, 'Box',  'off', 'TickDir', 'out');
xlim([0, n_clus+2]);
ylim([0, 0.20]);

figure(fh2)
l = legend(legend_label);
set(l, 'Interpreter', 'none')

xlabel('Movement types'); ylabel('Movement fractions')
set(gca,'XTick', 1/(n_group+1)*((n_group+1)/2-0.5)+(1:n_clus), 'XTickLabel', 1:n_clus, 'Box',  'off', 'TickDir', 'out');
xlim([0, n_clus+2]);
ylim([0, max(boxPlot_data_all(:, 3))]);


mvFractions_grouped = struct2table(mvFractions_grouped);


