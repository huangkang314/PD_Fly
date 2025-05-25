function plot_fig1C_trace(data_2d, cut_range, fs, bodyPart_name)

% %% ����ȥ���Ļ�
% raw_XY = expdata;
% 
% mean_X = mean(raw_XY(1:2:(end-1),:));
% mean_Y = mean(raw_XY(2:2:end,:));
% white_XY = raw_XY;
% white_XY(1:2:(end-1),:) = white_XY(1:2:(end-1),:)-mean_X;
% white_XY(2:2:end,:) = white_XY(2:2:end,:)-mean_Y;

%% ���󱳲����Ļ���β�͸�������x�����ᣬ��������ת
% back_X = white_XY(25,:);
% back_Y = white_XY(26,:);
% back_XY = white_XY;
% back_XY(1:2:(end-1),:) = back_XY(1:2:(end-1),:)-back_X;
% back_XY(2:2:end,:) = back_XY(2:2:end,:)-back_Y;
% root_tail_X = back_XY(27,:);
% root_tail_Y = back_XY(28,:);
% rot_alpha = -atan2(root_tail_Y,root_tail_X);%��ת��
% 
% rot_XY = zeros(size(back_XY));
% for m = 1:size(rot_alpha,2)
%     rot_mat = [cos(rot_alpha(1,m)),sin(rot_alpha(1,m)),0;...
%         -1*sin(rot_alpha(1,m)),cos(rot_alpha(1,m)),0;...
%         0,0,1];
%     temp_rot = ...
%         [back_XY(1:2:(end-1),m),back_XY(2:2:end,m),ones(size(rot_XY,1)/2,1)]*rot_mat;
%     rot_XY(1:2:(end-1),m) = temp_rot(:,1);
%     rot_XY(2:2:end,m) = temp_rot(:,2);
% end
% 
% rot_XY = rot_XY';
% N1 = 1; N2 = size(rot_XY, 1);
% fea_list = (rot_XY(:,:)/50 + double(1:1:size(rot_XY, 2)))';
% fea_list = fea_list(:, cut_range(1):cut_range(2));

ms_data = [];
ms_data(:, :) = data_2d(1:end/2, :) - mean(data_2d(1:end/2, :));
ms_data(end+1:end*2, :) = data_2d(end/2+1:end, :) - mean(data_2d(end/2+1:end, :));
zsdata = zscore(ms_data(:,:)',[],2)/3;
N1 = 1; N2 = size(zsdata, 1);
fea_list = (zsdata(:,:)+double(1:1:size(zsdata,2)))';
fea_list = fea_list(:, cut_range(1):cut_range(2));

timeLine = linspace(N1-1, (N2-N1+1)/fs, N2-N1+1);
timeLine = timeLine(:, cut_range(1):cut_range(2));

n_bodyParts = length(bodyPart_name);
feat_names = cell(1, n_bodyParts*2);
for ib = 1:n_bodyParts
    feat_names{ib*2-1} = [bodyPart_name{ib}, 'X'];
    feat_names{ib*2} = [bodyPart_name{ib}, 'Y'];
end

fea_list = flipud(fea_list);
feat_names = flip(feat_names);


% clrM = cbrewer2('RdBu', 11);
% clrM(6:7, :) = [];
% clrM = [[0.4124 0.0012 0.1573]; clrM; [0.2244 0.2639 0.5213]; [0.1314 0.1396 0.3321]];
% clrM = flipud(clrM);
clrM = jet(9);

figure
hold on
set(gcf, 'Position', [300, 100, 1200, 400])
for li = 1:size(fea_list, 1)/2
    for lii = 1:2
%         plot(timeLine, fea_list((li-1)*2 + lii, :)', 'Color', clrM(li, :), 'LineWidth', 1);
        plot_data_sm = smooth(fea_list((li-1)*2 + lii, :)', fs/2);
        plot(timeLine, plot_data_sm, 'Color', clrM(li, :), 'LineWidth', 1);
    end
end
hold off
set(gca, 'YLim', [-2, size(fea_list, 1)+2], 'YTick', 1:n_bodyParts*2+0.5 ,'YTickLabel', feat_names, ...
    'FontSize', 10, 'Box', 'off', 'LineWidth', 1, 'TickDir', 'out', 'TickLength',[0.003, 0.003], 'TickLabelInterpreter','none')

axis off

%% narrow trace

% figure
%
% set(gcf, 'Position', [300, 300, 1200, 230])
% for li = 1:size(fea_list, 1)/2
%     for lii = 1:2
%         subplot('Position', [0.05 0.1+((li-1)*2+lii)*0.027 0.90 0.02])
%         plot(timeLine, fea_list((li-1)*2 + lii, :)', 'Color', clrM(li, :), 'LineWidth', 1);
%         axis off
%     end
% end
% set(gca, 'FontSize', 13, 'TickDir', 'out', 'TickLength',[0.005, 0.005], 'Box', 'off', 'LineWidth', 2)
%
% subplot('Position', [0.05 0.13 0.90 0]);
% plot(timeLine, timeLine)
% set(gca, 'FontSize', 11, 'TickDir', 'out', 'TickLength',[0.005, 0.005], 'Box', 'off', 'LineWidth', 4)
%
% print(gcf, '-dtiff', '-r300',['./figures/fig12_Raw_feaTraceXLabel_narrow', '.tiff']);


