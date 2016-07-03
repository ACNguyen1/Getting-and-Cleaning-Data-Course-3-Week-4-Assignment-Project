## run_analysis.R 
## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.	Uses descriptive activity names to name the activities in the data set.
## 4.	Appropriately labels the data set with descriptive variable names.
## 5.	From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject. 

install.packages("plyr")
library(plyr)

## If data directory exists, create data directory
if(!file.exists("./data")) 
  {
    dir.create("./data")
  }

## Download and unzip data files    
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./data/UCI_HAR_Dataset_zipfile.zip", mode="wb")
setwd("./data")
unzip("UCI_HAR_Dataset_zipfile.zip", files = NULL, list = FALSE, overwrite = TRUE,
        junkpaths = FALSE, exdir = ".", unzip = "internal", setTimes = FALSE)

## Read Data Descriptions: features and labels
activity_Labels <- read.table(paste("UCI HAR Dataset", "/activity_labels.txt", sep=""))
features_Info <- read.table(paste("UCI HAR Dataset", "/features.txt", sep=""))

## Read Testing Data: subject data, x data and y data
subj_Test <- read.table(paste("UCI HAR Dataset", "/test/subject_test.txt", sep=""), col.names=c("Subject"))
X_Test <- read.table(paste("UCI HAR Dataset", "/test/X_test.txt", sep=""))
Y_Test <- read.table(paste("UCI HAR Dataset", "/test/y_test.txt", sep=""), col.names=c("Activity"))

## Read Training Data: subject data, x data and y data
subj_Train <- read.table(paste("UCI HAR Dataset", "/train/subject_train.txt", sep=""), col.names=c("Subject"))
X_Train <- read.table(paste("UCI HAR Dataset", "/train/X_train.txt", sep=""))
Y_Train <- read.table(paste("UCI HAR Dataset", "/train/y_train.txt", sep=""), col.names=c("Activity"))

###1.	Merges the training and the test sets to create one data set.
combined_Test <- cbind(subj_Test, Y_Test, X_Test)
combined_Train <- cbind(subj_Train, Y_Train, X_Train)
merged_Data <- rbind(combined_Test, combined_Train)

### 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
col_list <- grep("[Mm]ean\\()|[Ss]td\\()", features_Info$V2)
col_list <- col_list + 2 ## add (Subject, Activity)
col_list <- c(1, 2, col_list)
merged_Data <- merged_Data[, c(col_list)]

### 3.	Uses descriptive activity names to name the activities in the data set.
merged_Data$Activity <- as.character(merged_Data$Activity)
activity_Labels$V1 <- as.character(activity_Labels$V1)
activity_Labels$V2 <- as.character(activity_Labels$V2)
for( i in 1:nrow(activity_Labels) ) {
  merged_Data$Activity <- gsub(activity_Labels[i,1], activity_Labels[i,2], merged_Data$Activity)
}

###4. Appropriately labels the data set with descriptive variable names.
col_names <- grep("[Mm]ean\\()|[Ss]td\\()", features_Info$V2, value=TRUE)
col_names <- c("Subject", "Activity", col_names)
names(merged_Data) <- col_names

### 5.	From the data set in step 4, creates a second, independent tidy data set with 
###    the average of each variable for each activity and each subject. 

tidy_Dataset <- group_by(merged_Data, Subject, Activity) %>%
  summarise_each(funs(mean))
write.table(tidy_Dataset, "./tidy_Dataset.txt", row.name=FALSE)
