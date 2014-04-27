The following file describes the raw data set and subsequent transformations
performed on the dataset as required by the Peer Assesment for the Coursera
course "Getting and Cleaning Data".
https://class.coursera.org/getdata-002/human_grading/view/courses/972080/assessments/3/submissions

# Raw Data
The raw data represents data collected from accelerometers from the Samsung Galaxy S smartphone. It can be obtained at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Data transformation
The main script for transforming the data is run_analysis.R in this repository. The first step was to download the raw data from the above link. This data was unzipped and the R working directory was set to the directory for the raw data. The main data directory contains two folders train and test. The data from X_train.txt, y_train.txt and subject_train.txt from the train folder was combined to produce a data frame train_data. Similarly the data from X_test.txt, y_test.txt and subject_test.txt from the test folder was combined to produce a data frame train_data. These two data frames were combined to form the data frame called combined_data with 10299 observations. There are 561 features described in the dataset for each Subject and each Activity representing various measurements. In the raw dataset these are described in the files features.txt and features_info.txt. Of these, the exercise required extracting features corresponding to means and standard deviations. So only these specific columns from the combined_data data frame were retained. The names for the columns were obtained from features.txt from the original dataset. The activity column from the original dataset lists activity ids as integers. Using activity_labels.txt from the original dataset, these values were tranformed to the actual activity names. 

Finally, for each subject and activity pair, the means of the measurements in the combined_data data frame were obtained, resulting in the tidy dataset required by the assignment. This data frame was named combined_data_reshaped. 
