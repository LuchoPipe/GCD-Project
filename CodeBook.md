---
title: "Code Book"
output: html_document
---
A R script called *run_analysis.R* transforms a splited dataset in a tidy dataset. 

* Merging datasets.
* Extracting specific columns.
* Using descriptive variables names.
    
Notes: 

- It is necessary download the [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip files inside the project folder.

---

mergeFeats function merges the training and the test sets (X) to create one data frame called "**measures**".
```{r}
measures <- mergeFeats("UCI HAR Dataset/test/X_test.txt", "UCI HAR Dataset/train/X_train.txt")
```
Then, selectFeats function selects a set of features names (mean and standard deviation) specified in features.txt file. These features are sorted and concatenated in a vector called "**features**".
```{r}
meanFeats <- selectFeats("UCI HAR Dataset/features.txt", "-mean\\(\\)")
stdFeats <- selectFeats("UCI HAR Dataset/features.txt", "-std\\(\\)")
features <- rbind(meanFeats, stdFeats)
features <- arrange(features, FeatId)
```

Afterwards, The data frame "**measures**" is composed by the set of measurements about the mean and standard deviation features. 
```{r}
measures <- select(measures, features[,1])
```
The loadActivities function loads activities Names and their ids in a data frame called "**acts**"
```{r}
acts <- loadActivities("UCI HAR Dataset/activity_labels.txt")
```
The loadFiles function allows us to load the subject and the activities "y"" from training and test set. These data frames are concatenated too in one data frame called "**table**".
```{r}
tableT <- loadFiles("UCI HAR Dataset/test/subject_test.txt", "UCI HAR Dataset/test/y_test.txt")
tableTr <- loadFiles("UCI HAR Dataset/train/subject_train.txt", "UCI HAR Dataset/train/y_train.txt")
table <- rbind(tableTr, tableT)
```

To facilitate reading, we use descriptive activity names to name the activities in the data set. Thus, the data frame "**table**" is merged with the activities Names "**acts**".
```{r}
table <- merge(table, acts, by="ActivityId") 
table <- select(table, Volunteer,ActivityName)
```

This code labels the data set with descriptive variable names and concatenate the data frame "**table**" and the measures for each volunteer. 
```{r}
names(measures) <- features[,2] 
table <- bind_cols(table,measures)
```

Finally , we create a tidy data set with the average of each variable for each activity and each subject called "**tidyTable**".
```{r}
tidyTable <- table 
%>% arrange(Volunteer) 
%>% group_by(Volunteer, ActivityName) 
%>% summarise_each(funs(mean))
```
