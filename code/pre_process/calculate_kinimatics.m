function behavior_data_table = calculate_kinimatics(behavior_data_table, fps)

nbodyparts = 9;

% [data_2d, data_name] = load_3dskl_h5(filepath, nbodyparts);

n_data = size(behavior_data_table, 1);

for id = 1:n_data(1)
    id_name =  behavior_data_table.sample_name{id};
    data_2d = behavior_data_table.data_2d_norm{id};
    body_parts = behavior_data_table.body_parts{id};
    % calculate frame-level paras
    frame_paras_table = calculate_frame_paras(data_2d, body_parts, nbodyparts, fps);   
    
%     frame_paras_table = array2table(frame_paras_table);
%     frameParas.Properties.VariableNames = parasName;
    
    behavior_data_table.frame_paras_table{id} = frame_paras_table;
    behavior_data_table.frame_paras_name{id} = frame_paras_table.Properties.VariableNames;
    
    behavior_data_table.frameParas_avg{id} = mean(table2array(frame_paras_table));
    
    %     main_name = strsplit(id_name, '_');
    %     main_name = main_name{1};
    %     savepath = [BeAMappingpath, main_name, '_frame_paras.csv'];
    
    %     paras_names = string(frame_paras_table.Properties.VariableNames)';
    %     frame_paras = table2array(frame_paras_table)';
    
    %     writetable(frame_paras_table, savepath)
    
    writetable(frame_paras_table, ['..\data\Movement_seq\', behavior_data_table.sample_name{id}, '_kineParas.csv'])
    
    %     disp(['Save: ', num2str(id), ' -> ', num2str(n_data(1))])
end