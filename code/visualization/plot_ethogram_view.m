function plot_ethogram_view(movement_table, select_mvClus)

n_samples = size(movement_table, 1);
tem_frameLabels = movement_table.frameLabels{1};
n_clus = max(tem_frameLabels);
%%
n_genColor = 9;
cclr = (cbrewer2('Set1', n_genColor));
[X, Y] = meshgrid([1:3], [1:n_clus]);
if n_clus > n_genColor
    clr = interp2(X(round(linspace(1, n_clus, n_genColor)), :), Y(round(linspace(1, n_clus, n_genColor)), :), cclr, X, Y);
else
    clr = cclr(1:n_clus, :);
end
clr = [[1, 1, 1]; clr];
%%
figure('Position',[333,200,709,100]);
hold on

frameLabels_segs_all = [];
for is = 1:n_samples
    tem_frameLabels = movement_table.frameLabels{is};
    len_mvSeq =  length(tem_frameLabels);

    tem_frameLabels_segs_select = zeros(size(tem_frameLabels));    
    for is_clus = select_mvClus
        tem_frameLabels_segs_select(tem_frameLabels == is_clus) = is_clus;
    end
    
    imagesc([0, len_mvSeq], is, tem_frameLabels_segs_select');
    

end
xlim([0, len_mvSeq]); ylim([0.5, n_samples+0.5])
set(gca,'XTick',[],'XTickLabel',[],'FontSize',10, 'YTick', 1:n_samples,'YTickLabel', movement_table.sample_name)
% set(gca,'XTick', linspace(0,len_mvSeq, 10), 'XTickLabel', linspace(0, len_mvSeq/segParas.fs, 10));
colormap(clr);
% clim([0 40]);
caxis([0 n_clus]);
% xlabel('Seconds');
yticks(1:n_samples);
% yticklabels(movement_table.sample_name');
ylabel('Samples');
% axis on;

% title('Movement Ethogram');

