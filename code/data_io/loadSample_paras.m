function sample_table = loadSample_paras(BeASegment_path, fileNames)

sample_table = struct();

n_sample = length(fileNames);

for id = 1:n_sample
    sample_name = fileNames{id,1}(1:end-20);
    sample_table(id).sample_name = sample_name;
    
    group_label = strsplit(sample_name, '-');
    group_label = group_label(3);
    sample_table(id).group_label = group_label;
    
    record_date = strsplit(sample_name, '-');
    record_date = strsplit(record_date{4}, '_');
    record_date = record_date{1}(1:end-6);    
    sample_table(id).record_date = record_date;
    
    mvLabel_data = importdata([BeASegment_path, fileNames{id,1}]);
    sample_table(id).frameLabels = mvLabel_data;
end
