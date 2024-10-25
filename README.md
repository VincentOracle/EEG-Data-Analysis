# ABOUT EEG Data Analysis
## 1. Introduction
The objective of this project was to analyze EEG data from a task-related pain study using various preprocessing steps and analytical methods. The analysis aimed to extract meaningful neural patterns, compute event-related potentials (ERPs), and assess spectral power and connectivity measures. This project utilized MATLAB and the EEGLAB toolbox for processing and analyzing the EEG data.
## 2. Data Acquisition
The dataset was obtained from a CSV file located at:
/MATLAB Drive/THE Model/eeglab_current/eeglab2024.2/sub-esgpilot02_task-pain_run-01_channels.tsv
This dataset contained EEG recordings from participants during a pain-related task.

## 3. Methodology
The analysis followed several key preprocessing steps:
Import Data- The EEG data was imported from a TSV file using the readtable function. The data was checked for structure and integrity.</br>
Filtering- A bandpass Butterworth filter was applied to the data with a low cutoff frequency of 1 Hz and a high cutoff frequency of 40 Hz to remove noise and artifacts.</br>
Re-referencing- The data was re-referenced using the average reference method to ensure consistent reference across channels.</br>
Epoching-The continuous EEG data was segmented into epochs from -200 ms to 800 ms around defined event onsets, allowing analysis of brain responses associated with specific stimuli.</br>
Baseline Correction-The mean amplitude during the baseline period (0 to 200 ms) was subtracted from each epoch to correct for baseline shifts.</br>
Artifact Detection and Removal-Outliers exceeding a defined threshold of 100 microvolts were detected and removed to ensure data quality.</br>
Rejection of Bad Channels- Channels identified as problematic were excluded from further analysis.</br>
Interpolation- Missing data points in the cleaned dataset were interpolated to maintain data integrity.</br>

## 4. Data Analysis
The following analyses were performed on the preprocessed data</br>
Event-Related Potentials (ERPs)- The average response across all epochs was computed to visualize the ERP waveform.</br>
Time Series Analysis- The cleaned data served as the basis for time series analysis, examining the temporal dynamics of EEG signals.</br>
Spectral Power Analysis- The power spectral density was estimated using the Welch method to assess frequency-specific brain activity.</br>
Connectivity Measures- Correlation coefficients between different channels were computed to analyze functional connectivity.</br>
Group Averages- Group averages were calculated to understand the overall neural response across participants.</br>

## 5. Statistical Testing
A one-sample t-test was conducted on the cleaned data to assess significant differences in the EEG responses. The results provided insights into whether the observed changes in brain activity were statistically significant.

## 6. Results
ERPs- The group average ERP waveform indicated the presence of specific neural responses to the pain-related task.
Spectral Power- Analysis revealed frequency bands with significant power changes during the task.
Connectivity- Connectivity measures indicated potential relationships between brain regions during the pain stimulus.

## 7. Conclusion
This project successfully demonstrated the application of EEG data preprocessing and analysis techniques to study neural responses associated with pain. The findings contribute to our understanding of how the brain processes pain stimuli and highlight the importance of robust preprocessing methods in EEG research. Future work could involve expanding the analysis to include more subjects or different experimental conditions to enhance the findings further.

## 8. Future Work
Future studies could explore:</br>
1.The influence of individual differences (e.g., pain sensitivity, psychological factors) on EEG responses.</br>
2.The application of machine learning techniques to classify EEG patterns associated with different types of pain stimuli.</br>
3.Longitudinal studies to assess changes in brain activity over time in response to pain treatment interventions.</br>
