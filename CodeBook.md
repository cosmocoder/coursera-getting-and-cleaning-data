# Code Book for Getting and Cleaning Data

## Introduction

This code book summarizes the steps taken to clean up the raw data and create a transformed tidy data set `tidy_data.txt`. The script `run_analysis.R` is used to generate the tidy data set.

A full description about the data is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And this is the data used for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Note that the `run_analysis.R` script expects the downloaded and unzipped data files to be placed in a folder called `data` at the root of the project directory.


## Steps to produce the tidy data

* The measurement values, labels and subject id's from the training data set is stored in the variables `trainSet`, `trainLabels` and `trainSubjects` respectively.

* Similarly, values from the test data set is stored in the variables `testSet`, `testLabels` and `testSubjects`.

* We first merge the measurement values, the measurement labels and the subject id's from both the training and test data sets using `rbind()` and store them in the variables `jointSet`, `jointLabels` and `jointSubjects`.

* The names of all the features in the downloaded raw data is read from `features.txt` and stored in the variable `featuresAll`.

* We create a numeric vector `featuresWanted` that holds the indices for the columns that contain either 'mean' or 'std' in their names.

* Using `featuresWanted` we extract only those columns from `jointSet` that contain the mean and standard deviation for each measurement. The names of the resulting columns in `jointSet` are cleaned up using regular expressions.

* In order to provide descriptive names for the activities we take the activity names and IDs from `activity_labels.txt`, store them in `activityLabels` and use that to apply proper names to the columns of `jointLabels`.

* We now merge the variables `jointSet`, `jointLabels` and `jointSubjects` through `cbind()` to create the combined data set called `allData`. The missing column names for the activities and subjects are added in the combined data set.

* Finally, we create a second, independent tidy data set with the average of each variable for each activity and each subject by using `ddply()` from the plyr package to apply the `colMeans()` function and save the data set to `tidy_data.txt`.