library(dplyr)

mergeFeats <- function(X_test, X_train){
	# Loading feature vector. 
	featuresT <- read.table(file = X_test)
	featuresTr <- read.table(file = X_train)
	rbind(featuresT, featuresTr)
}

loadFiles <- function(subject, y_test){
	# Loading subject and activities 
	subjectT <- read.table(file = subject)
	names(subjectT) <- c("Volunteer")
	activitiesT <- read.table(file = y_test)
	names(activitiesT) <- c("ActivityId")
	# Merging  columns from subject, activities and features data frames.
	table <- cbind(subjectT, activitiesT)
}

loadActivities <- function(actFile){
	activities <- read.table(file = actFile)
	names(activities) <- c("ActivityId", "ActivityName")
	#Encodes the ActivityName column as a factor
	activities$ActivityName <- as.factor(activities$ActivityName)
	activities
}

selectFeats <- function(featsFile, feat){
	feats <- read.table(file = featsFile)
	names(feats) <- c("FeatId", "FeatName")
	featsSubset <- feats[grep(feat, feats$FeatName), ]
}

# 1. Merges the training and the test sets to create one data set called "measures".
measures <- mergeFeats("UCI HAR Dataset/test/X_test.txt", "UCI HAR Dataset/train/X_train.txt")

# Selects the mean and standard deviation features in features.txt file
meanFeats <- selectFeats("UCI HAR Dataset/features.txt", "-mean\\(\\)")
stdFeats <- selectFeats("UCI HAR Dataset/features.txt", "-std\\(\\)")
features <- rbind(meanFeats, stdFeats)
features <- arrange(features, FeatId)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
measures <- select(measures, features[,1])

# Loading activities Names and their ids
acts <- loadActivities("UCI HAR Dataset/activity_labels.txt")
# Loading the subject and y from training and the test set.
tableT <- loadFiles("UCI HAR Dataset/test/subject_test.txt", "UCI HAR Dataset/test/y_test.txt")
tableTr <- loadFiles("UCI HAR Dataset/train/subject_train.txt", "UCI HAR Dataset/train/y_train.txt")
# Merging the subjects and ys to create one data set.
table <- rbind(tableTr, tableT)
# Wraps the data frame in a "data frame tbl"
table <- tbl_df(table)
# 3. Uses descriptive activity names to name the activities in the data set
table <- merge(table, acts, by="ActivityId") 
table <- select(table, Volunteer,ActivityName)

# 4. Appropriately labels the data set with descriptive variable names. 
names(measures) <- features[,2] 
measures <- tbl_df(measures)
table <- bind_cols(table,measures)

# 5. Creating a tidy data set with the average of each variable for each activity and each subject.
tidyTable <- table %>% arrange(Volunteer) %>% group_by(Volunteer, ActivityName) %>% summarise_each(funs(mean))
write.table(tidyTable, file = "tidyDataSet.txt", row.name=FALSE)










