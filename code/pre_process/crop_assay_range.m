function behavior_data_table = crop_assay_range(behavior_data_table)

n_samples = size(behavior_data_table, 1);

for id = 1:n_samples
    f_frame = figure;
    vid_frame = read(behavior_data_table.vid_handle{id, 1}, 1);
    imshow(vid_frame);
    set(f_frame, 'Position', [400, 200, 800, 600]);
    p = drawrectangle('LineWidth', 7, 'Color', 'cyan');
    crop_pos = round(p.Position);
    crop_pos = [crop_pos(1) crop_pos(2) crop_pos(1)+crop_pos(3) crop_pos(2)+crop_pos(4)];
    assay_wid = crop_pos(3) - crop_pos(1);
    assay_len = crop_pos(4) - crop_pos(2);
    close 
    
    data_2d = behavior_data_table.data_2d{id, 1};
    data_2d_norm = data_2d;
    data_2d_norm(:, 1:2:end) = data_2d(:, 1:2:end) - crop_pos(1);
    data_2d_norm(:, 2:2:end) = data_2d(:, 2:2:end) - crop_pos(2);
    data_2d_norm(:, 2:2:end) = assay_len - data_2d_norm(:, 2:2:end);
    
%     posX = data_2d(:, 2*body_partIdx-1) - crop_pos(1);
%     posY = data_2d(:, 2*body_partIdx) - crop_pos(2);
%     posY = assay_len - posY;
    
    % test trjac
    %     crop_frame = vid_frame(crop_pos(2):crop_pos(4), crop_pos(1):crop_pos(3), :);
    %     clc;
    %     imshow(crop_frame)
    %     set(f, 'Position', [400, 200, 800, 600]);
    %     hold on
    %     plot(posX, posY)
 
    data_2d_norm(:, 1:2:end) = 100*data_2d_norm(:, 1:2:end)/assay_wid;
    data_2d_norm(:, 2:2:end) = 100*data_2d_norm(:, 2:2:end)/assay_len;
    
    behavior_data_table.data_2d_norm{id} = data_2d_norm;
    behavior_data_table.crop_pos{id} = crop_pos;
end



