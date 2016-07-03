# Getting-and-Cleaning-Data-Course-3-Week-4-Assignment-Project
## To create the run_analysis.R that performs the following steps as described in the assignment's instructions:
## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.	Uses descriptive activity names to name the activities in the data set.
## 4.	Appropriately labels the data set with descriptive variable names.
## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The UCI HAR Dataset zip file is downloaded from the provided URL: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and unzip to local "data" directory.
Package "plyr" is installed and plyr library is loaded and used.
The dimension of the resulted tidy data set (tidy_Dataset.txt) is 180 rows and 68 columns. The first two columns are Subject and Activity and the rest of 66 columns are the average of mean values and standard deviation values.
