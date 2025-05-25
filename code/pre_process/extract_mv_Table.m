function behavior_data_table = extract_mv_Table(BeAOutputs_path, behavior_data_table)

sample_table = struct();
n_sample = size(behavior_data_table, 1);

for id = 1:n_sample
    
    
    filename = behavior_data_table.sample_name{id};
    
    h5_Movement_features = import_hdf5([BeAOutputs_path, filename, '_results.h5'], '/Movement_features');
    mvLabel_data = h5_Movement_features.movement_label;
    segBoundary = h5_Movement_features.segBoundary;
    label_number = segBoundary - [0; segBoundary(1:end-1)];
    sample_table(id).frameLabels = repelem(mvLabel_data, label_number);

    disp([num2str(id), ' -> ', num2str(n_sample)])
end

%% calculate movement fractions
[sample_table, mv_fractions] = cal_mvFraction(sample_table);

sample_table = struct2table(sample_table);

behavior_data_table.frameLabels = sample_table.frameLabels;
behavior_data_table.mv_fractions = sample_table.mv_fractions;


























