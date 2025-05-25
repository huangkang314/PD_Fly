function plot_fig1A_skeleton(HACA_struct, fi, VidObj)

bodyPart_name = {'nose', 'L-ear', 'R-ear', 'neck', 'LF-limb', 'RF-limb', 'LH-limb', ...
    'RH-limb', 'LF-claw', 'RF-claw', 'LH-claw', 'RH-claw', 'back', ...
    'RT-tail', 'Mid-tail', 'Tip-tail'};

clrM = cbrewer2('Spectral', 16);
clrM(8:10, :) = [];
clrM = [[0.4124 0.0012 0.1573]; clrM; [0.2244 0.2639 0.5213]; [0.1314 0.1396 0.3321]];
clrM = flipud(clrM);

expdata = [(HACA_struct.DLC_data.raw_beh_cell{2:17,2:3})];
cut_off = 3000;

frame = read(VidObj, fi + cut_off);
% figure; imshow(frame)
wid = size(frame, 2); hit = size(frame, 1); 
frame = imrotate(frame(35:500, 355:820, :), 180);
frame = flip(frame ,2);

x_max = max(expdata(fi, 1:end/2)) - 355 + 10;
x_min = min(expdata(fi, 1:end/2)) - 355 - 10;
y_min = -max(expdata(fi, 1+(end/2):end)) + hit - 35 - 10;
y_max = -min(expdata(fi, 1+(end/2):end)) + hit - 35 + 10;
x_cent = (x_max + x_min)/2;
y_cent = (y_max + y_min)/2;
x_Wid = x_max - x_min;
y_Wid = y_max - y_min;
if x_Wid > y_Wid
    y_min = y_cent + x_Wid/2;
    y_max = y_cent - x_Wid/2;
else
    x_min = x_cent - y_Wid/2;
    x_max = x_cent + y_Wid/2;
end

figure
set(gcf, 'Position', [300, 300, 400, 300])
imshow(frame)
axis([x_min, x_max, y_min, y_max])
print(gcf, '-dtiff', '-r300',['fig1A_frame', '.tiff']);
print(gcf, '-depsc', '-r900','-painters', ['fig1A_frame', '.eps']);

x_max = max(expdata(fi, 1:end/2))+10;
x_min = min(expdata(fi, 1:end/2))-10;
y_max = max(expdata(fi, 1+(end/2):end))+10;
y_min = min(expdata(fi, 1+(end/2):end))-10;
x_cent = (x_max + x_min)/2;
y_cent = (y_max + y_min)/2;
x_Wid = x_max - x_min;
y_Wid = y_max - y_min;
if x_Wid > y_Wid
    y_min = y_cent - x_Wid/2;
    y_max = y_cent + x_Wid/2;
else
    x_min = x_cent - y_Wid/2;
    x_max = x_cent + y_Wid/2;
end
[f_wid, f_hit, ~] = size(frame);
figure
set(gcf, 'Position', [300, 300, f_wid, f_hit])
subplot('Position', [0 0 1 1]);
plot_skeleton(expdata, fi, '.', 25, clrM, bodyPart_name)
axis([x_min, x_max, y_min, y_max])
set(gcf, 'InvertHardcopy', 'off')

% set(gca, 'Color', 'none', 'FontSize', 16, 'ytick',[], 'TickDir', 'out', 'TickLength',[0.005, 0.005], 'Box', 'off', 'LineWidth', 1.5)


