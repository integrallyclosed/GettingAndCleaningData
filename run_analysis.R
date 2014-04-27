# Assume the working directory is set to UCI HAR Dataset

# Read data from X_train.txt, y_train.txt and subject_train.txt and 
# store them in individual data frames. Combine the three data frames into
# a single train_data data frame. Note that the delimiter in X_train.txt is a space
# while y_train.txt and subject_train.txt have one entry per line.
X_train <- read.table('train/X_train.txt')
y_train <- read.table('train/y_train.txt')
subject_train <- read.table('train/subject_train.txt')
train_data <- cbind(X_train, y_train, subject_train)

# Read data from X_test.txt, y_test.txt and subject_test.txt and 
# store them in individual data frames. Combine the three data frames into
# a single test_data data frame. Note that the delimiter in X_test.txt is a space
# while y_test.txt and subject_test.txt have one entry per line.
X_test <- read.table('test/X_test.txt')
y_test <- read.table('test/y_test.txt')
subject_test <- read.table('test/subject_test.txt')
test_data <- cbind(X_test, y_test, subject_test)

# Combine the train and test data sets into a common data set.
combined_data <- rbind(train_data, test_data)

# Extract feature names from features.txt and assign them as column names for the 
# combined data set. Add column names for Activity and Subject columns.
features <- read.table('features.txt', stringsAsFactors = F)
feature_names <- features[,2]
column_names <- c(feature_names, 'Activity', 'Subject')
names(combined_data) <- column_names

# Extract only those columns of the data set which represent a mean or standard deviation
# along with the Activity and Subject columns
columns_with_mean_std <- c(grep("mean\\(\\)",feature_names), grep("std\\(\\)",feature_names))
combined_data <- combined_data[ ,c(columns_with_mean_std, which(colnames(combined_data) == "Activity"), which(colnames(combined_data) == "Subject"))]

# Extract activity labels and replace the numerical labels in the activity
# column by textual names of the activities.
activity_labels <- read.table('activity_labels.txt')
combined_data$Activity <- factor(combined_data$Activity, labels = activity_labels[,2])

# Load the reshape2 library to melt and cast the data to create the 
# tidy dataset of the average of each variable for each activity and each subject
library(reshape2)
combined_data_molten <- melt(combined_data, id.vars = c("Activity", "Subject"))
combined_data_reshaped <- dcast(combined_data_molten, Subject + Activity ~ variable, mean)