function frame_paras_table = calculate_frame_paras(data_2d, body_parts, n_bodyParts, fps)

data_2d = fillmissing(data_2d, 'linear');  % mat 格式
body_part_name = body_parts;

% n_bodyParts = size(data_3d.body_part_name{1}, 2);
frame_paras_table = table();

speed_raw = diff(data_2d);

%% 2D speed
speed2 = sqrt(speed_raw(:, 1:2:end).^2 + speed_raw(:, 2:2:end).^2);
speed2 = speed2/(1/fps);
speed2 = [speed2(1, :); speed2];
speed_sm2 = speed2;

% add speed to table
for ib = 1:n_bodyParts
%     speed_sm2(:, ib) = smooth(speed2(:, ib), fps*1/2);
    %     disp(data_3d.body_part_name{1}{ib})
    eval(['speed_', body_part_name{ib}, '= speed_sm2(:, ib);']);
    eval(['frame_paras_table = addvars(frame_paras_table,', 'speed_', body_part_name{ib}, ');']);
end

%% calculate accelerate
acc_raw = diff([speed_raw(1, :); speed_raw]);

acc2 = sqrt(acc_raw(:, 1:2:end).^2 + acc_raw(:, 2:2:end).^2);
acc2 = acc2/(1/fps);
acc2 = [acc2(1, :); acc2];
acc_sm2 = acc2;

% add speed to table
for ib = 1:n_bodyParts
%     acc_sm2(:, ib) = smooth(acc2(:, ib), fps*1/2);
    eval(['acc_', body_part_name{ib}, '= acc_sm2(:, ib);']);
    eval(['frame_paras_table = addvars(frame_paras_table,', 'acc_', body_part_name{ib}, ');']);
end

%% cumulative distance
X_bodyCent = mean(data_2d(:, 1:2:end), 2);
Y_bodyCent = mean(data_2d(:, 2:2:end), 2);

frame_dist= [0; smooth(abs(sqrt((diff(X_bodyCent).^2) + (diff(Y_bodyCent).^2))), fps*1/2)];
% cumulative_dist= cumsum(frame_dist);

% add cumulative_dist to table
eval(['frame_paras_table = addvars(frame_paras_table,', 'frame_dist);']);

%% in center
% if nargin == 1
% if nargin == 2
%     centX = (max(X_bodyCent) + min(X_bodyCent))/2;
%     centY = (max(Y_bodyCent) + min(Y_bodyCent))/2;
%     rad = max([max(X_bodyCent) - centX, max(Y_bodyCent) - centY])/2;
% end

% calculate time in center

inCent_idx =  X_bodyCent > 25 & X_bodyCent < 75 & Y_bodyCent > 25 & Y_bodyCent < 75;

% add in_cent to table
eval(['frame_paras_table = addvars(frame_paras_table,', 'inCent_idx);']);












