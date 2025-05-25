function behavior_data_table = load_behav_data(working_path, file_names)

n_files = length(file_names);

% load all the behavior_data_table
behavior_data_table = struct();

for id = 1:n_files
    tem_file_name = [working_path, file_names{id}];
    
    dlc_data = importdata(tem_file_name);
    
    if isstruct(dlc_data) %case when excel contains column or row headers
        body_parts_all = strsplit(dlc_data.textdata{2, 1}, ',');
        body_parts = {body_parts_all{2:3:end}};
        dlc_data = dlc_data.data;
    end
    dlc_data = dlc_data(:,2:end);
    data2dllh = dlc_data(:,3:3:end);
    zero_idx = (sum(data2dllh') == 0);   
    data2dllh(zero_idx, :) = [];
    dlc_data(:, 3:3:end) = [];
    dlc_data(zero_idx, :) = [];
    
    sample_name = file_names{id,1}(1:end-44);
%     vid_name = [working_path, sample_name, '.avi'];
%     vid_handle = VideoReader(vid_name);
   
    behavior_data_table(id).sample_name = sample_name;
%     behavior_data_table(id).vid_handle = vid_handle;

    behavior_data_table(id).group_label = 'Unknown';
    behavior_data_table(id).body_parts = {body_parts};
    behavior_data_table(id).data_2d = dlc_data;
    behavior_data_table(id).data2dllh = data2dllh;
    
end

behavior_data_table = struct2table(behavior_data_table);
