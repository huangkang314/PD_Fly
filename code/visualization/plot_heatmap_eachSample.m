function behavior_data_table = plot_heatmap_eachSample(behavior_data_table)

n_samples = size(behavior_data_table, 1);

body_partIdx = 2;

fh1 = figure;
set(fh1, 'Position', [400, 80, 800, 800])  

for id = 1:n_samples
    data_2d_norm = behavior_data_table.data_2d_norm{id};
    
    posX = data_2d_norm(1:1200, 2*body_partIdx-1);
    posY = data_2d_norm(1:1200, 2*body_partIdx);
    
    pos = [posX, posY];
    smoothPower = 10; % Power of the smooth for the data (get rid of noise)
    posX = smooth(posX, smoothPower);
    posY = smooth(posY, smoothPower);
    
    speed = diff(pos);%*1.13/1000; % pixel2m
    speed = [speed; speed(end, :)];
    speed = sqrt(speed(:, 1).^2 + speed(:, 2).^2);
    speed = smooth(speed, smoothPower);
    
    %% plot Speed
    % colcol = magma(100);
    % colcol = flip(cbrewer2('RdBu', 100));
    colcol = jet(100);
    colcollist = zeros(size(posX,1)-1,3);
    
    fh1;
%     subplot(4, 10, id)

    subaxis(4,10, id, 'Spacing', 0.001, 'Padding', 0.02, 'Margin', 0.00);
    for i = 1 : length(posX)-1
        if isnan(speed(i)) == 0
            speedVal = round((speed(i) - min(speed))/(max(speed)-min(speed)) * 100) + 1;
            
            if speedVal > 100
                speedVal = 100; % Dirty solving of speed outlayers...
            end
            colcollist(i,:) = colcol(speedVal, :);
        end
    end
    scatter(posX(1:end-1), posY(1:end-1),10*ones(size(posY(1:end-1))), colcollist,'filled')

    axis equal; set(gca, 'Color', 'w', 'XTick', [], 'YTick', []); box on;
    title(behavior_data_table.sample_name{id})
    xlim([0, 100]); ylim([0, 100])
    h = getframe(gcf);
    speedData = h.cdata;
    %     print(gcf, '-djpeg', [working_path, 'results/figures/', data_dir(j).name(1:end-4), '_speedmap.jpg'], '-r300')
    %     close
    
end

