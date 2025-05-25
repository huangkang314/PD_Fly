function [sample_table, mv_fractions] = cal_mvFraction(sample_table)

n_sample = length(sample_table);
% get maximal cluster number
n_clus = 0;
for i = 1:n_sample
    n_clus = max([n_clus; sample_table(i).frameLabels]);
end

mv_fractions = zeros(n_sample, n_clus);
for is = 1:n_sample
    tem_frameLabel = sample_table(is).frameLabels;
    [count, index] = hist(tem_frameLabel, 1:n_clus);
    mv_fractions(is, index) = count/length(tem_frameLabel);
    sample_table(is).mv_fractions = [mv_fractions(is, :)];
end



