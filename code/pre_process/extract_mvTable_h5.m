function sample_table = extract_mvTable_h5(BeAOutputs_path)

%% detect all the files with '_Movement_Labels' suffix
dirOutput = dir([BeAOutputs_path, '*_results.h5']); 
fileNames = {dirOutput.name}';
fileNames = natsort(fileNames);
n_sample = length(dirOutput);

%% load all the movement labels and creat sample table
sample_table = loadSample_paras_h5(BeAOutputs_path, fileNames);

%% calculate movement fractions
[sample_table, mv_fractions] = cal_mvFraction(sample_table);

sample_table = struct2table(sample_table);




























