# Getting and Cleaning Data Course Project Code
# This code is to;
# download a raw Human Activity Recognition Using Smartphones Dataset
# read data
# clean and manipulate data for further analysis

# Folder Operations to Download Data --------------------------------------
# Get path to working directory
work_dir_main = getwd()

# Location of data folder
path_to_data = file.path(work_dir_main, "data")

# Create a data folder in the working directory if not exists
if(!file.exists(path_to_data)) {dir.create(path_to_data)}

# Download and Unzip Dataset -----------------------------------------------------------
# Download the dataset
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest = file.path(path_to_data, "UCI_HAR_Dataset.zip")
download.file(url, dest, method = "curl")

# Extract the dataset and obtain the file path to main UCI HAR Dataset folder
setwd(path_to_data)
unzip(dest)
work_dir = getwd() 
path_to_UCI = file.path(work_dir, "UCI HAR Dataset")
setwd(path_to_UCI)

# Read Data ---------------------------------------------------------------

# Read activity labels and feature names of the measurements seperately
activity_labels = read.table("activity_labels.txt", stringsAsFactors = FALSE)
features = read.table("features.txt", stringsAsFactors = FALSE)

# Obtain file paths to test and training datasets
path_to_train = file.path(path_to_UCI, "train")
path_to_test = file.path(path_to_UCI, "test")

# Change work_dir to training folder and read features, labels and subjects of training data
# The data is given without features names
setwd(path_to_train)
X_train = read.table("X_train.txt", sep = "", header = FALSE, strip.white = TRUE)
y_train = read.table("y_train.txt", sep = "", header = FALSE)
subject_train = read.table("subject_train.txt", sep = " ", header = FALSE)

# Create training dataset
train_dataset = cbind(subject_train, X_train, y_train)

# Change work_dir to test folder and read features, lables and subjects of training data
# The data is given without features names
setwd(path_to_test)
X_test = read.table("X_test.txt", sep = "", header = FALSE, strip.white = TRUE)
y_test = read.table("y_test.txt", sep = "", header = FALSE)
subject_test = read.table("subject_test.txt", sep = " ", header = FALSE)

# Create training dataset
test_dataset = cbind(subject_test, X_test, y_test)

# Combine Test and Training Data ------------------------------------------

# Create complete dataset by combining training and test datasets
complete_dataset = rbind(train_dataset, test_dataset)

# Add feature names to complete dataset
feature_names = c("Subject_ID", features$V2, "Activity")
names(complete_dataset) = feature_names


# Manipulate Data ---------------------------------------------------------

# Find features related with the mean and standard deviation for each measurement
mean_features = grep("mean\\()", features$V2, value = TRUE)
std_features = grep("std\\()", features$V2, value = TRUE)

# Obtain features to be extracted from the complete dataset
features_to_be_extracted = c("Subject_ID", "Activity", mean_features, std_features)

# Obtain the extracted dataset
extracted_dataset = complete_dataset[features_to_be_extracted]

# Name the activities for each measurement by using the given activity labels
extracted_dataset[,"Activity"] = factor(extracted_dataset[,"Activity"], labels = activity_labels$V2)

# Obtain the dataset which calculates the avearge of the each extracted feature
# for each activity and each subject
mean_std_data = aggregate(extracted_dataset[c(mean_features, std_features)],
by = extracted_dataset[c("Subject_ID", "Activity")], FUN = mean)
mean_std_data = mean_std_data[order(mean_std_data$Subject_ID),]

# Write Processed Data to Output File -------------------------------------

# Location of the output folder
path_to_output = file.path(work_dir_main, "output")

# Create output folder if not exists
if(!file.exists(path_to_output)) { dir.create(path_to_output) }

# Create the path to output file and write the manipulated data
outputFile = file.path(path_to_output, "meanStdAverage_UCI_HAR.txt")
write.table(mean_std_data, outputFile, row.names = FALSE)
