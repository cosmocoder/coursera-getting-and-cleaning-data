# The plyr package is loaded to use the ddply() function
library(plyr)


##
# Step 1:  merge the training and test data
##

# First load the training data
trainSet <- read.table('data/train/X_train.txt')   # training set
trainLabels <- read.table('data/train/y_train.txt')  # training labels
trainSubjects <- read.table('data/train/subject_train.txt')  # subjects who performed tasks

# then load the test data
testSet <- read.table('data/test/X_test.txt')   # test set
testLabels <- read.table('data/test/y_test.txt')  # test labels
testSubjects <- read.table('data/test/subject_test.txt')  # subjects who performed tasks

# merge the respective training and test data columns
jointSet <- rbind(trainSet, testSet)
jointLabels <- rbind(trainLabels, testLabels)
jointSubjects <- rbind(trainSubjects, testSubjects)


##
# Step 2: Extract only the measurements on the mean and standard deviation
##

featuresAll <- read.table('data/features.txt')

# get only columns with mean() or std() in their names
featuresWanted <- grep('-(mean|std)\\(\\)', featuresAll[, 2])

# subset the desired columns
jointSet <- jointSet[, featuresWanted]
names(jointSet) <- featuresAll[featuresWanted, 2]
names(jointSet) <- gsub('[()]', '', names(jointSet))    # remove the '()'
names(jointSet) <- gsub('mean', 'Mean', names(jointSet))
names(jointSet) <- gsub('std', 'Std', names(jointSet))
names(jointSet) <- gsub('-', '', names(jointSet))


##
# Step 3: Use descriptive activity names
##

activityLabels <- read.table('data/activity_labels.txt')

# update activity names
jointLabels[, 1] <- activityLabels[jointLabels[, 1], 2]

# add the appropriate column name
names(jointLabels) <- 'activity'


##
# Step 4: Appropriately label the data set with descriptive variable names
##

names(jointSubjects) <- 'subject'

# merge all data columns into a single data set
allData <- cbind(jointSet, jointLabels, jointSubjects)


##
# Step 5: Create a second independent tidy data set with the average of each variable
# for each activity and each subject.
##

# exclude the last two columns since they correspond to 'activity' and 'subject'
tidyData <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:(ncol(allData) - 2)]))
write.table(tidyData, 'tidy_data.txt', row.name = FALSE, quote = FALSE)