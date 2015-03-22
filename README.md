# HAR-data-analysis
Human Activity Recognition Using Smartphones data analysis

Before start Download data form https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract it to the project working directory.
You can find detail information about the data in the link - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

run_analysis.R script was created to complete the work.
Description, how the script works:

 1. Load dplyr library, which is used to complete script.
 2. Load labels for Features and Activities.
 3. Load Train and Test data sets:
        - Column names loaded in the same time when data loading by using col.names argument.
 5. Merge the train and the test set in one dataset:
        - merge subject.train, y.train and x.train to assotiate train data with subjects and activities.
        - merge subject.test, y.test and x.test to assotiate train data with subjects and activities.
 6. Extract mean and standard deviation for each measurement:
        - create list, which is contains only required measurements.
        - add Activity and Subject indexes to the begining of the list.
        - filter merged set with the train and test data to get only mean and standard deviation measurements.
 7. Set descriptive labels for the Activities instead of numbers.
 8. Set descriptive names for the variables in the merget dataset.
 9. Create data set with the average of each variable for each activity and each subject.
10. Export tidy result set created in step 9.
11. Result file HAR_result.txt can be found in the working directory.

