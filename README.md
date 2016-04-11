# Getting and Cleaning Data project 

This repo holds the project files for the Getting and Cleaning Data course in Coursera. The raw data used for this project is obtained from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The R script `run_analysis.R` does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final generated data set is stored in the `tidy_data.txt` file. The steps taken to produce this data set are listed in `CodeBook.md`.