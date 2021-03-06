# For run_analysis.R to work, dplyr and reshape2 packages must be installed
# and loaded.
library(dplyr)
library(reshape2)

# Read in the test/train .txt files, and the features.txt file. The features.txt
# file will be used to provide the column names for the mean and standard
# deviation measurement variables.
stest <- read.table("subject_test.txt")
strain <- read.table("subject_train.txt")
ytest <- read.table("y_test.txt")
ytrain <- read.table("y_train.txt")
xtest <- read.table("X_test.txt")
xtrain <- read.table("X_train.txt")
datanames <- read.table("features.txt")

# Combine the test and train data sets into three data sets called 'subjects,'
# 'activities,' and 'data.' Rename the factor levels in the 'activities' data set
# to be descriptive. Rename the columns in the 'data' data set to be descriptive.
subjects <- rbind(stest, strain)
subjects <- rename(subjects, subject = V1)
activities <- rbind(ytest, ytrain)
activities <- rename(activities, activity = V1)
activities$activity <- recode(activities$activity, '1' = 'walking', 
                              '2' = 'walking_upstairs', 
                              '3' = 'walking_downstairs', '4' = 'sitting', 
                              '5' = 'standing', '6' = 'laying')
data <- rbind(xtest, xtrain)
names(data) <- datanames$V2

# Subset 'data' so that the only column variables included contain the 
# expressions "mean()" OR "std()." meanFreq() measurements were excluded.
data <- data[, grepl("mean\\(\\)", names(data)) | grepl("std\\(\\)", 
                                                        names(data))]

# Combine 'subjects,' 'activities,' and 'data' into one data set called 'bigtable.'
bigtable <- cbind(subjects, activities, data)

# Reshape 'bigtable' into a tidy data set called 'tidytable' using melt/cast.
# 'tidytable' contains the average for all measurements, organized by subject
# and activity.
melted <- melt(bigtable, id.vars = c("subject", "activity"))
tidytable <- dcast(melted, subject+activity ~ variable, mean)

# Write 'tidytable' to a .txt file in your working directory.
write.table(tidytable, "tidytable.txt", row.names = FALSE)