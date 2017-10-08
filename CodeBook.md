# Code Book

This document describes the code `run_analysis.R' which is used to download a raw dataset from UCI (University of California, Irvine) database and manipulate the data for further analysis.

## Human Activity Recognition Using Smartphones Dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

Notes:

* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.

## dataProcess.R

The code is splitted (by comments) in some sections:

* Folder Operations to Download Data
* Download and Unzip Dataset
* Read Data
* Combine Test and Training Data
* Manipulate Data
* Write Processed Data to Output File

### Folder Operations to Download Data

* Get working directory to 'work_dir_main' and create a data folder at the path 'path_to_data'.

### Download and Unzip Dataset

* Download the UCI HAR dataset at the given 'url' with the file name 'UCI_HAR_Dataset.zip' under data folder with the specified destination 'dest'.
* Extract the dataset under data folder and obtain the file path to main UCI HAR Dataset folder which is 'path_to_UCI'.

### Read Data

* Read activity labels and feature names of the measurements seperately as:
'activity_labels' and 'features' from 'activity_labels.txt' and 'features.txt' files. 
* Obtain file paths to test and training datasets which are 'path_to_train' and 'path_to_test'
* First, read the training data which includes the feature vectors, labels and subjects. This information is stored in 'X_train', 'y_train' and 'subject_train' variables and read from 'X_train.txt', 'y_train.txt' and 'subject_train.txt' files. All training data is stored in 'train_dataset'.
* Secondly, read the test data which includes the feature vectors, labels and subjects. This information is stored in 'X_test, y_test' and 'subject_test' variables and read from 'X_test.txt', 'y_test.txt' and 'subject_test.txt' files.All test data is stored in 'test_dataset'.

### Combine Test and Training Data

* Create 'complete_dataset' by combining training and test datasets.
* Add 'feature_names' to complete dataset.

### Manipulate Data

* Find features related with the mean and standard deviation for each measurement and store them in 'mean_features' and 'std_features'.
* Obtain features to be extracted from the complete dataset in 'features_to_be_extracted'.
* Obtain the extracted dataset which is 'extracted_dataset'.
* Name the activities for each measurement by using the given activity labels.
* Obtain the dataset which calculates the avearge of the each extracted feature for each activity and each subject and store them in 'mean_std_data'.
* Order the 'mean_std_data' by 'Subject_ID'.

### Write Processed Data to Output File

* Obtain the location of the output folder, 'path_to_output'.
* Create the output folder if not exists
* Create the path to output file and write the manipulated data to 'output_file'