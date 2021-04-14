dinfo = dir('*.log');

data(:,:,:) = zeros(8, 10, 3);
% LR x Value x Iteration

% Learning rates 0.2 0.1 0.05 0.02 0.015 0.01 0.005 0.001

for n = 1 : length(dinfo)
    fileName = dinfo(n).name;
    lr = str2double(append("0.", erase(fileName, ["CFD", ".log", "First", "Second", "Third"])));
    
    if lr == 0.2
        lrIDX = 1;
    elseif lr == 0.1
        lrIDX = 2;
    elseif lr == 0.05
        lrIDX = 3;
    elseif lr == 0.02
        lrIDX = 4;
    elseif lr == 0.015
        lrIDX = 5;
    elseif lr == 0.01
        lrIDX = 6;
    elseif lr == 0.005
        lrIDX = 7;
    elseif lr == 0.001
        lrIDX = 8;
    end
    
    iteration = erase(fileName, ["CFD", ".log"]);
    index = find(isletter(iteration), 1);
    iteration(1:index-1) = [];
    
    fprintf(iteration);
    
    if strcmp(iteration, 'First')
        iterIDX = 1;
    elseif strcmp(iteration, 'Second')
        iterIDX = 2;
    else
        iterIDX = 3;
    end
    
    FID = fopen(fileName);
    fileData = textscan(FID, '%s');
    fclose(FID);
    
    % Idx 4 & 5 = F1 Loss mean & variance
    % Idx 8 & 9 = Dice mean & variance
    % Idx 12 & 13 = Jaccard mean & variance
    % Idx 16 & 17 = Precision mean & variance
    % Idx 20 & 21 = Recall mean & variance
    stringData = string(fileData{:});
    
    data(lrIDX, 1, iterIDX) = str2double(stringData{4});
    data(lrIDX, 2, iterIDX) = str2double(stringData{5});
    data(lrIDX, 3, iterIDX) = str2double(stringData{8});
    data(lrIDX, 4, iterIDX) = str2double(stringData{9});
    data(lrIDX, 5, iterIDX) = str2double(stringData{12});
    data(lrIDX, 6, iterIDX) = str2double(stringData{13});
    data(lrIDX, 7, iterIDX) = str2double(stringData{16});
    data(lrIDX, 8, iterIDX) = str2double(stringData{17});
    data(lrIDX, 9, iterIDX) = str2double(stringData{20});
    data(lrIDX, 10, iterIDX) = str2double(stringData{21});
    
    data(isnan(data))=0;
end

subplot(2, 5, 1);
plot(data(:, 1, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 1, 2), '-o', 'MarkerSize', 5);
plot(data(:, 1, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
legend({'First Run', 'Second Run', 'Third Run'},'Location','southwest')
xlabel('LR') 
title('CFD F1 Loss Mean');

subplot(2, 5, 6);
plot(data(:, 2, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 2, 2), '-o', 'MarkerSize', 5);
plot(data(:, 2, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD F1 Loss Variance');

subplot(2, 5, 2);
plot(data(:, 3, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 3, 2), '-o', 'MarkerSize', 5);
plot(data(:, 3, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD Dice Mean');

subplot(2, 5, 7);
plot(data(:, 4, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 4, 2), '-o', 'MarkerSize', 5);
plot(data(:, 4, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD Dice Variance');

subplot(2, 5, 3);
plot(data(:, 5, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 5, 2), '-o', 'MarkerSize', 5);
plot(data(:, 5, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD Jaccard Mean');

subplot(2, 5, 8);
plot(data(:, 6, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 6, 2), '-o', 'MarkerSize', 5);
plot(data(:, 6, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD Jaccard Variance');

subplot(2, 5, 4);
plot(data(:, 7, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 7, 2), '-o', 'MarkerSize', 5);
plot(data(:, 7, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD Precision Mean');

subplot(2, 5, 9);
plot(data(:, 8, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 8, 2), '-o', 'MarkerSize', 5);
plot(data(:, 8, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD Precision Variance');

subplot(2, 5, 5);
plot(data(:, 9, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 9, 2), '-o', 'MarkerSize', 5);
plot(data(:, 9, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD Recall Mean');

subplot(2, 5, 10);
plot(data(:, 10, 1), '-o', 'MarkerSize', 5);
hold on;
plot(data(:, 10, 2), '-o', 'MarkerSize', 5);
plot(data(:, 10, 3), '-o', 'MarkerSize', 5);
hold off;
xticks([1, 2, 3, 4, 5, 6, 7, 8]);
xticklabels({0.2, 0.1, 0.05, 0.02, 0.015, 0.01, 0.005, 0.001});
xtickangle(45);
xlabel('LR') 
title('CFD Recall Variance');
