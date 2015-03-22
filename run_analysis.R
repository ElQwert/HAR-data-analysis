
#-Load libraries-
library(dplyr)

#-Read Labels for Features and Activities-
features <- read.table(file = "./UCI HAR Dataset/features.txt")
activity.labels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", col.names = c("Activity", "ActivityName"))

#-Load data-
#--Train
x.train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
y.train <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", col.names = "Activity")
subject.train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

#--Test
x.test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
y.test <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
subject.test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

#-Merges the training and the test sets to create one data set.
#--Merge x.train, y.train and subject.train to assotiate train data with subjects and activities
train <- bind_cols(subject.train, y.train, x.train)
#--Merge x.test, y.test and subject.test to assotiate test data with subjects and activities
test <- bind_cols(subject.test, y.test, x.test)
result <- bind_rows(train, test)

#-Extracts only the measurements on the mean and standard deviation for each measurement.
#--Get list the mean and standard deviation for each measurement.
req.features <- filter(features, grepl('mean\\(|std\\(', V2))
#--Add Activites and Subjects to the variables vector
req.features <- c(c(1:2), req.features[, 1]+2)
result <- result[, req.features]

#-Set name the activities in the result.set
result <- inner_join(activity.labels, result, by = "Activity")
result <- select(result, -Activity)

#-Set descriptive names for variables
colnames(result) <- gsub("BodyBody", "Body", colnames(result))
colnames(result) <- gsub("\\.mean\\.\\.\\.", "-mean()-", colnames(result))
colnames(result) <- gsub("\\.std\\.\\.\\.", "-std()-", colnames(result))
colnames(result) <- gsub("\\.mean\\.\\.", "-mean()", colnames(result))
colnames(result) <- gsub("\\.std\\.\\.", "-std()", colnames(result))

#-creates data set result.mean, with the average of each variable for each activity and each subject.
result.mean <- result %>% group_by(ActivityName, Subject) %>%
        summarise_each(funs(mean))

#-Export result.mean data set.
write.table(result.mean, file = "./HAR_result.txt", row.name = FALSE)

