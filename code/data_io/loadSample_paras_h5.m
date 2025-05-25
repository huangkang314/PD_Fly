function sample_table = loadSample_paras(BeAOutputs_path, fileNames)

sample_table = struct();
n_sample = length(fileNames);

for id = 1:n_sample
    filename = fileNames{id,1};
    sample_name = strsplit(filename, '_');
    sample_name = sample_name{1};
    sample_table(id).sample_name = sample_name;
    
    group_label = strsplit(sample_name, '-');
    group_label = group_label(3);
    sample_table(id).group_label = group_label;
    
    record_date = strsplit(sample_name, '-');
    record_date = strsplit(record_date{4}, '_');
    record_date = record_date{1}(1:end-6);    
    sample_table(id).record_date = record_date;
    
    h5_Movement_features = import_hdf5([BeAOutputs_path, filename], '/Movement_features');
    mvLabel_data = h5_Movement_features.movement_label;
    segBoundary = h5_Movement_features.segBoundary;
    label_number = segBoundary - [0; segBoundary(1:end-1)];
    sample_table(id).frameLabels = repelem(mvLabel_data, label_number);

    disp([num2str(id), ' -> ', num2str(n_sample)])
end

