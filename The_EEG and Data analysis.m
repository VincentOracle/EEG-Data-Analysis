
% Clear the workspace and command window
clear; clc;

% Load the necessary EEGLAB library

cd('/MATLAB Drive/THE Model/eeglab_current');
addpath(genpath('/MATLAB Drive/THE Model/eeglab_current')); 
savepath;  % Save the changes

% Initialize EEGLAB
eeglab; 

% Import EEG data from CSV file
data = readtable('/MATLAB Drive/THE Model/eeglab_current/eeglab2024.2/sub-esgpilot02_task-pain_run-01_channels.csv');

% Check the structure of the data to identify the columns
disp(data);

% Extract relevant columns for EEG data and convert types if needed
eeg_data = data{:, 3:end}; % Adjust as necessary based on your dataset structure
eeg_data = cell2mat(eeg_data); % Convert cell array to numeric array if applicable

% Filtering parameters
low_cutoff = 1; % Low cutoff frequency (Hz)
high_cutoff = 40; % High cutoff frequency (Hz)
fs = 250; % Sampling frequency (Hz)

% Bandpass filter
[b, a] = butter(2, [low_cutoff high_cutoff] / (fs / 2), 'bandpass');
filtered_data = filtfilt(b, a, eeg_data);

% Re-referencing (average reference)
re_reference_data = filtered_data - mean(filtered_data, 2);

% Epoching (e.g., from -200 ms to 800 ms around events)
event_onset = 1; % Example onset (you'll need to adjust based on your data)
epoch_length = [0.2, 0.8]; % Start and end in seconds
num_samples = size(re_reference_data, 1);
epoch_start = round(event_onset * fs) + round(epoch_length(1) * fs);
epoch_end = round(event_onset * fs) + round(epoch_length(2) * fs);

epochs = re_reference_data(epoch_start:epoch_end, :);

% Baseline correction
baseline_period = [0, 0.2]; % 0 to 200 ms baseline
baseline_start = round(event_onset * fs) + round(baseline_period(1) * fs);
baseline_end = round(event_onset * fs) + round(baseline_period(2) * fs);
baseline_mean = mean(re_reference_data(baseline_start:baseline_end, :), 1);
baseline_corrected_data = epochs - baseline_mean;

% Artifact detection and removal
% Define thresholds for detection
threshold = 100; % microvolts
artifacts = abs(baseline_corrected_data) > threshold;
cleaned_data = baseline_corrected_data(~any(artifacts, 2), :);

% Rejection of bad channels
% Example of rejecting channels (you can specify which channels to exclude)
bad_channels = []; % Specify bad channels here
cleaned_data(:, bad_channels) = [];

% Interpolation if needed
% Assuming cleaned_data has gaps that need interpolation
if any(isnan(cleaned_data), 'all')
    for i = 1:size(cleaned_data, 2)
        if any(isnan(cleaned_data(:, i)))
            cleaned_data(:, i) = fillmissing(cleaned_data(:, i), 'linear');
        end
    end
end

% Extracting ERP, time series, spectral power, and connectivity measures
erp = mean(cleaned_data, 1);
time_series = cleaned_data; % Using cleaned_data as time series
spectral_power = pwelch(cleaned_data, [], [], [], fs);
connectivity_measure = corr(cleaned_data);

% Compute group averages (if you have multiple subjects, average across them)
% Assuming group_data is a 3D array where the first dimension is subjects
group_average = mean(cleaned_data, 1);

% Plotting group averages
time_vector = (1:size(group_average, 2)) / fs; % Time vector in seconds
figure;
plot(time_vector, group_average);
xlabel('Time (s)');
ylabel('Amplitude (uV)');
title('Group Average ERP');

% Statistical test (e.g., t-test between conditions)
% Adjust based on your conditions
[~, p_value] = ttest(cleaned_data); % Example: one-sample t-test

% Save the results
save('EEG_Analysis_Results.mat', 'erp', 'time_series', 'spectral_power', 'connectivity_measure', 'group_average', 'p_value');
