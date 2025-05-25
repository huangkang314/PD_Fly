function plot_avgerr(data, col, fs)
avg = mean(data);
stderr = std(data, 0, 1) / sqrt(size(data, 1));
% stderr = std(data, 0, 1);

time = (1:size(data, 2))/fs;

stderrvals = [avg + stderr, avg(end:-1:1) - stderr(end:-1:1)];

fill([time, time(end:-1:1)], stderrvals, ...
    col, 'facealpha', .3, 'edgealpha', .05);
hold on
plot(time, avg, 'Color', col, 'LineWidth', 2);
xlim([time(1), time(end)])
