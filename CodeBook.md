---
title: "Code Book"
output: html_document
---
A R script called *run_analysis.R* transforms a splited dataset in a tidy dataset. 

* Merging datasets.
* Extracting specific columns.
* Using descriptive variables names.
    
## Variables

The output of this experiment is a tidy dataset composed by a set of variables corresponding to a set of persons (30 volunteers) which have executed a set of activities (6 activities). In this way, the columns of this tidy dataset are:

 * Volunteers : Identifier of each volunteer in the experiment.
 * ActivityName : Activity executed by the volunteer (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING).

A set of variables that were estimated from each measurement (tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyAccJerk-XYZ, tBodyGyro-XYZ, tBodyGyroJerk-XYZ, tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccMag, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag) in the original dataset:

 * mean(): Mean value for each activity and each subject.
 * std(): Standard deviation for each activity and each subject.
 
 ---
 Notes: 
 
  * '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
  * For more information about the original dataset at this [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).