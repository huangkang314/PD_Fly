%% settings
clc; clear; close all;
addpath(genpath('data_io'));
addpath(genpath('pre_process'));
addpath(genpath('visualization'));

working_path = '..\data\DLC_kine\';
dirOutput = dir([working_path, '*DLC_resnet50_Fly_PDOct26shuffle1_1030000.csv']);
file_names = {dirOutput.name}';
file_names = natsort(file_names);
n_files = length(file_names);
fps = 25;

%% load dlc data
behavior_data_table = load_behav_data(working_path, file_names);
% behavior_data_table = crop_assay_range(behavior_data_table);
load('..\data\behavior_data_table_croped.mat')

WT_index  = find(contains(behavior_data_table.sample_name,'wt') | ...
    contains(behavior_data_table.sample_name,'WT') | contains(behavior_data_table.sample_name,'Wt'));
PD_index  = find(contains(behavior_data_table.sample_name,'pd') | contains(behavior_data_table.sample_name,'PD'));
behavior_data_table.group_label(WT_index,:) = {'WT'};
behavior_data_table.group_label(PD_index,:) = {'PD'};

%% plot speed map
behavior_data_table = plot_heatmap_eachSample(behavior_data_table);

%% calculate kinimatics
behavior_data_table = calculate_kinimatics(behavior_data_table, fps);

kine_table_grouped = plot_grouped_kineParas_onlyBoxplot(behavior_data_table);

plot_grouped_kineParas_lowD(behavior_data_table)

plot_grouped_kineParas_clusterGram(behavior_data_table)

% kine_classification(behavior_data_table)

%% movement analysis
working_path = '..\data\';

BeAMapping_path = [working_path,'Movement_seq/'];
behavior_data_table = extract_mv_Table(BeAMapping_path, behavior_data_table);

select_mvClus =  1:10;
plot_ethogram_view(behavior_data_table, select_mvClus)

mvFractions_grouped = plot_grouped_mvFractions_onlyBoxplot(behavior_data_table);

% plot_grouped_mvFractions_eachParas(behavior_data_table);

% plot low embeddings
plot_grouped_mvFractions_lowD(behavior_data_table);

% plot clustergram
plot_grouped_mvFractions_clusterGram(behavior_data_table) 

%%
features = [cell2mat(behavior_data_table.frameParas_avg), behavior_data_table.mv_fractions];
labels = behavior_data_table.group_label;










