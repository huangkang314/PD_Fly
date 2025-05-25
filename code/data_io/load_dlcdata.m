%Loading DLC 2D tracked data
function [data2d,data2dllh,flag_mis] = load_dlcdata(fullfilename, nframes, nfeatures, flag_mis)
data2d = importdata(fullfilename);
if isstruct(data2d) %case when excel contains column or row headers
    data2d = data2d.data;
end
data2d = data2d(:,2:end);
data2dllh = data2d(:,3:3:end);
data2d(:,3:3:end) = [];

if nframes~= size(data2d,1)
    flag_mis = 1;
end

if nfeatures*2 ~= size(data2d,2)
    flag_mis = 1;
end

end