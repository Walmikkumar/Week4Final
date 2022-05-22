# Week4Final

Getting and Cleaning Data, week 4 final assignment

This 'Week4Final' repo contains a run_analysis.R script, all the txt files needed, and a CodeBook which describes all the variables and data transformations used in this assignment.

The subject_test, subject_train, y_test, y_train, X_test, X_train, and features txt files need to be in your working directory for run_analysis.R to work. run_analysis.R will import these txt files using read.table.

The activity_labels.txt file is not used in run_analysis.R, it's been included in this repo as a reference. activity_labels.txt describes the activity that corresponds to the factor levels (1-6) in the original y_test and y_train txt files. I renamed the factor levels using the descriptions in activity_labels.txt.
