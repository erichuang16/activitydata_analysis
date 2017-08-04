##course 3 project

setwd('/Users/Eric/Desktop/R_course')
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "activitydata.zip", method = "curl")
unzip("activitydata.zip")

#reading features
features <- read.table("./UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#reading activity labels:
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])

#Extract only the data on  mean and std, then unify mean and std 
features_need <- grep(".*mean.*|.*std.*", features[,2])
features_need.names <- features[features_need,2]
features_need.names = gsub('-mean', 'Mean', features_need.names)
features_need.names = gsub('-std', 'Std', features_need.names)
features_need.names <- gsub('[-()]', '', features_need.names)

# Reading trainings tables:
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")[features_need]
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subject_train, y_train, x_train)

# Reading test tables:
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")[features_need]
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subject_test, y_test, x_test)

#merge datasets and add labels
allinone <- rbind(train, test)
colnames(allinone) <- c("subject", "activity", features_need.names)

# turn activity and subjects into factors
allinone$activity <- factor(allinone$activity, levels = activity_labels[,1], labels = activity_labels[,2])
allinone$subject <- as.factor(allinone$subject)

allinone.melted <- melt(allinone, id = c("subject", "activity"))
allinone.mean <- dcast(allinone.melted, subject + activity ~ variable, mean)

write.table(allinone.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
