##Introduction
The script run_analysis.R aimed at providing a tidy data set that represents human activity.

##Source data
The source data was gained thanks to a experiments described bellow.
The whole data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones or https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 

The data is split into two data sets, train and test data sets.

for more information read README.txt that can be found in the above links. Read also features_info.txt to have more information on the provided features.

##run_analysis.R script
In order to have run_analysis.R run you have to download the zip file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and to unzip it's content in your R working directory.

The script does the following things:
* Loadings and concatenating the sets: Because test sets and train sets has the exact same structure, the code to load the data is not duplicated for each set but a for loop is used instead. The result of this fist steep is three data frames subject, X and Y. X contains the values of all the features, Y contains the id of the activities that lead to those features and subject contains the id of the subject whose feactures bellong to. Note that the train rows are added to the test rows during the second round of the for loop thanks to the rbind function. Note also that the file features.txt is use to automaticaly set columns names.
* Deleting unneeded features. Only mean and standard deviation of mesurments are kept. Logical vectors are used to do the selection. Because of symmetry in the featrues organisation, rep fonction could be used facilitate selection.
* Merging subject, X and Y data frame. The file activity_labels.txt gives the name of the activities associates to the ids. This file could be used to add a column in Y which old activities names (using the merge function). cbind function is used to put together subject, activity and X (features values). The activities ids are deleted afterward using the "-which" function.
* Averaging of each variable for each activity and each subject. This is done in one instruction using the aggregate function.
* Ordering by subject and activity. This was'nt required but it makes the data more readable.
* Writing the data in a file named "activity.txt".

##Data output
See file CodeBook.md to have more information on the produced data.


