function [feat_space_h5] = import_hdf5(hdf5path, Groupname)
info = h5info(hdf5path, Groupname);
datasets = info.Datasets;
ndatasets = length(datasets);

feat_space_h5 = [];
for i = 1:ndatasets
%     disp(i)
    datasets_name = datasets(i).Name;
    datasets_field = h5read(hdf5path, strcat(Groupname, '/', datasets_name));
    
    if size(datasets_field, 1) == 1
        feat_space_h5 = [feat_space_h5, datasets_field'];
    elseif size(datasets_field, 1) ~= 1
        feat_space_h5 = [feat_space_h5, datasets_field];
    end
end
feat_space_h5 = array2table(feat_space_h5);
feat_space_h5.Properties.VariableNames = {datasets.Name};




