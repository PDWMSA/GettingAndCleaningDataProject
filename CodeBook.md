---
title: "CodeBook"
author: "PDWMSA"
date: "October 10, 2018"
output: word_document
---

Script details:
==============
-Original data pulled from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
-Packages employed: "readr", "dplyr", "tidyr" 


Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
-For more information about this dataset contact: activityrecognition@smartlab.ws

For each record it is provided:
======================================
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The Original dataset includes the following files (all of which accessible from the oringal dowloadsite):
=========================================
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.

These elements were used in the process of creating a Tidy data set and in the script in this repo:

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.


The following files are available for the train and test data. Their descriptions are equivalent:

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


The script works through the data to create a final tidy data set with the average of each feature for each subject and activity in this order:
==============================================================================================================================================
1)Creates the C:/Data directory, loads in and unzips the data from the above URL

2)Installs (if necessary) and loads the above mentioned packages

3)used the "read.table" function to calls in  the necessary data to R

4)Combines the "test" and "train" data sets for the subjects, Activites, and Domain Variables (measurements) 

5)Replaces activity codes with activity descriptions (1-WALKING, 2-WALKING_UPSTAIRS, 3-WALKING_DOWNSTAIRS, 4-SITTING, 5-STANDING, 6-LAYING) to the "CombinedActivityLabel" data frame using a simple apply/if function

6)Renames the columns appropriately using "Subject" for subjects in the "CombinedSubjects" data frame and the features or descriptiions of the measurements from the "features" data frame as column names for the created "Combined_domain_variables" data frame

7)We are asked only to keep measures of mean and std deviation ("mean", "std" in the feature descriptions) this step removes all others from the created "Combined_domain_variables"-- Note it is not clear if "meanfreq" measurements should be kept or removed, I have removed them but if you would like them to be kept and flow through to the final tidy data frame simply remove or comment out the line:

Combined_domain_variables <- Combined_domain_variables[!grepl("Freq", colnames(Combined_domain_variables))]

8)Combined the [combined test / train] data sets into one complete data set with all subjects, activities, and features

9)Use the gsub() function to clean up the names of the features to make them more descriptive and legible 

10)Use the gather/group_by/summarise functions (from the tidyr package) on the data frame created in step 4 to create a final tidy data set giving the average of each measurement for each subject and activity called "TidyAvgSubjectFeature"


Objects created:

activity_labels -> Data frame created from original data with codes for corresponding activity being measured 
features -> Data frame created from original data with list of the measurements taken for each action 
test_subject -> Data frame created from original data with numeric identifying the subject performing the activities while wearing the phone (from the test group)  
test_domain_variables -> Data frame created from original data with measurements for each feature (from the test group)  
test_activity_label -> Data frame created from original data with ID for the activities being performed by the subject (from the test group)
train_subject -> Data frame created from original data with subjects performing the activities while wearing the phone (from the train group)
train_domain_variables ->  Data frame created from original data with measurements for each feature (from the train group) 
train_activity_label -> Data frame created from original data with ID for the activities being performed by the subject (from the train group)

CombinedSubject -> test_subject and train_subject data frames above combined using the rbind() function
CombinedActivityLabel -> test_activity_label and train_activity_label data frames above combined using the rbind() function
Combined_domain_variables -> test_domain_variables and train_domain_variables data frames above combined using the rbind() function

Combined_data_set -> data framce created by using the cbind() function on the three above data frames which is the complete data fram with the subject, activity (description) and measurements taken for each of the features

TidyAvgSubjectFeature -> a final tidy data set giving the average of each measurement for each subject and activity called created using the "gather", "Group_by", and "summarize" functions within the "tidyr" package 




Technical Codebooks (Combined_data_set (Created in Step 4 of the Assignment or 8 above) & TidyAvgSubjectFeature (Created in step 5 of the assignment or 10 above) data frames)
===========================================================================

Codebook for Combined_data_set:

Autogenerated data summary from dataMaid
2018-10-10 09:09:17
Data report overview

The dataset examined has the following dimensions:
Feature	Result
Number of observations	10299
Number of variables	68
Codebook summary table
Variable	      Class	# unique values	    Missing	 
subject          integer	    30	        0.00 %	
activity         character	    6	        0.00 %	
timebodyaccmeanx numeric	    10292	    0.00 %	
timebodyaccmeany numeric	    10299	    0.00 %	
timebodyaccmeanz numeric	    10293	    0.00 %	
timebodyaccstdx  numeric	    10295	    0.00 %	
timebodyaccstdy  numeric    	10297   	0.00 %	
timebodyaccstdz  numeric	    10297	    0.00 %	
timegravityaccmeanx numeric	    10296	    0.00 %	
timegravityaccmeany numeric	    10298	    0.00 %	
timegravityaccmeanz numeric	    10299	    0.00 %	
timegravityaccstdx  numeric	    10288	    0.00 %	
timegravityaccstdy  numeric	    10293	    0.00 %	
timegravityaccstdz  numeric	    10296	    0.00 %	
timebodyaccjerkmeanx numeric	10299	    0.00 %	
timebodyaccjerkmeany numeric	10299	    0.00 %	
timebodyaccjerkmeanz numeric	10299	    0.00 %	
timebodyaccjerkstdx  numeric	10290	    0.00 %	
timebodyaccjerkstdy  numeric	10296   	0.00 %	
timebodyaccjerkstdz  numeric	10293	    0.00 %	
timebodygyromeanx    numeric	10298	    0.00 %	
timebodygyromeany    numeric	10299	    0.00 %	
timebodygyromeanz    numeric	10297	    0.00 %	
timebodygyrostdx     numeric	10292	    0.00 %	
timebodygyrostdy     numeric	10296	    0.00 %	
timebodygyrostdz     numeric	10296	    0.00 %	
timebodygyrojerkmeanx numeric	10295	    0.00 %	
timebodygyrojerkmeany numeric	10299	    0.00 %	
timebodygyrojerkmeanz numeric	10298	    0.00 %	
timebodygyrojerkstdx  numeric	10292   	0.00 %	
timebodygyrojerkstdy  numeric	10295	    0.00 %	
timebodygyrojerkstdz  numeric	10291	    0.00 %	
timebodyaccmagmean    numeric	10296	    0.00 %	
timebodyaccmagstd     numeric	10294	    0.00 %	
timegravityaccmagmean numeric	10296	    0.00 %	
timegravityaccmagstd  numeric	10294	    0.00 %	
timebodyaccjerkmagmean numeric	10292	    0.00 %	
timebodyaccjerkmagstd  numeric	10294	    0.00 %	
timebodygyromagmean    numeric	10298	    0.00 %	
timebodygyromagstd     numeric	10298	    0.00 %	
timebodygyrojerkmagmean numeric	10293	    0.00 %	
timebodygyrojerkmagstd numeric	10297	    0.00 %	
frequencybodyaccmeanx  numeric	10295	    0.00 %	
frequencybodyaccmeany  numeric	10292	    0.00 %	
frequencybodyaccmeanz  numeric	10295	    0.00 %	
frequencybodyaccstdx   numeric	10294	    0.00 %	
frequencybodyaccstdy   numeric	10297	    0.00 %	
frequencybodyaccstdz   numeric	10296	    0.00 %	
frequencybodyaccjerkmeanx numeric	10293	0.00 %	
frequencybodyaccjerkmeany numeric	10296	0.00 %	
frequencybodyaccjerkmeanz numeric	10294	0.00 %	
frequencybodyaccjerkstdx numeric	10291	0.00 %	
frequencybodyaccjerkstdy numeric	10294	0.00 %	
frequencybodyaccjerkstdz numeric	10290	0.00 %	
frequencybodygyromeanx numeric	10297	    0.00 %	
frequencybodygyromeany numeric	10296	    0.00 %	
frequencybodygyromeanz numeric	10297	    0.00 %	
frequencybodygyrostdx  numeric	10297	    0.00 %	
frequencybodygyrostdy  numeric	10293	    0.00 %	
frequencybodygyrostdz  numeric	10295	    0.00 %	
frequencybodyaccmagmea numeric	10296	    0.00 %	
frequencybodyaccmagstd numeric	10298	    0.00 %	
frequencybodyaccjerkmagmean numeric	10290	0.00 %	
	frequencybodyaccjerkmagstd numeric	10296	0.00 %	
	frequencybodygyromagmean numeric	10297	0.00 %	
	frequencybodygyromagstd numeric	10296	0.00 %	
	frequencybodygyrojerkmagmean numeric	10293	0.00 %	
	frequencybodygyrojerkmagstd numeric	10292	0.00 %	


Variable list:
subject
Feature	Result
Variable type	integer
Number of missing obs.	0 (0 %)
Number of unique values	30
Median	17
1st and 3rd quartiles	9; 24
Min. and max.	1; 30
 
________________________________________
activity
Feature	Result
Variable type	character
Number of missing obs.	0 (0 %)
Number of unique values	6
Mode	"LAYING"
 
.	Observed factor levels: "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS".
________________________________________
timebodyaccmeanx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10292
Median	0.28
1st and 3rd quartiles	0.26; 0.29
Min. and max.	-1; 1
 
________________________________________
timebodyaccmeany
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10299
Median	-0.02
1st and 3rd quartiles	-0.02; -0.01
Min. and max.	-1; 1
 
________________________________________
timebodyaccmeanz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10293
Median	-0.11
1st and 3rd quartiles	-0.12; -0.1
Min. and max.	-1; 1
 
________________________________________
timebodyaccstdx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10295
Median	-0.94
1st and 3rd quartiles	-0.99; -0.25
Min. and max.	-1; 1
 
________________________________________
timebodyaccstdy
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	-0.84
1st and 3rd quartiles	-0.98; -0.06
Min. and max.	-1; 1
 
________________________________________
timebodyaccstdz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	-0.85
1st and 3rd quartiles	-0.98; -0.28
Min. and max.	-1; 1
 
________________________________________
timegravityaccmeanx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	0.92
1st and 3rd quartiles	0.81; 0.95
Min. and max.	-1; 1
 
________________________________________
timegravityaccmeany
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10298
Median	-0.14
1st and 3rd quartiles	-0.24; 0.12
Min. and max.	-1; 1
 
________________________________________
timegravityaccmeanz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10299
Median	0.04
1st and 3rd quartiles	-0.12; 0.22
Min. and max.	-1; 1
 
________________________________________
timegravityaccstdx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10288
Median	-0.98
1st and 3rd quartiles	-0.99; -0.96
Min. and max.	-1; 1
 
________________________________________
timegravityaccstdy
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10293
Median	-0.98
1st and 3rd quartiles	-0.99; -0.95
Min. and max.	-1; 1
 
________________________________________
timegravityaccstdz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.97
1st and 3rd quartiles	-0.99; -0.93
Min. and max.	-1; 1
 
________________________________________
timebodyaccjerkmeanx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10299
Median	0.08
1st and 3rd quartiles	0.06; 0.09
Min. and max.	-1; 1
 
________________________________________
timebodyaccjerkmeany
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10299
Median	0.01
1st and 3rd quartiles	-0.02; 0.03
Min. and max.	-1; 1
 
________________________________________
timebodyaccjerkmeanz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10299
Median	0
1st and 3rd quartiles	-0.03; 0.02
Min. and max.	-1; 1
 
________________________________________
timebodyaccjerkstdx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10290
Median	-0.95
1st and 3rd quartiles	-0.99; -0.29
Min. and max.	-1; 1
 
________________________________________
timebodyaccjerkstdy
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.93
1st and 3rd quartiles	-0.99; -0.22
Min. and max.	-1; 1
 
________________________________________
timebodyaccjerkstdz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10293
Median	-0.95
1st and 3rd quartiles	-0.99; -0.55
Min. and max.	-1; 1
 
________________________________________
timebodygyromeanx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10298
Median	-0.03
1st and 3rd quartiles	-0.05; -0.01
Min. and max.	-1; 1
 
________________________________________
timebodygyromeany
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10299
Median	-0.07
1st and 3rd quartiles	-0.1; -0.05
Min. and max.	-1; 1
 
________________________________________
timebodygyromeanz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	0.09
1st and 3rd quartiles	0.06; 0.11
Min. and max.	-1; 1
 
________________________________________
timebodygyrostdx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10292
Median	-0.9
1st and 3rd quartiles	-0.99; -0.48
Min. and max.	-1; 1
 
________________________________________
timebodygyrostdy
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.91
1st and 3rd quartiles	-0.98; -0.45
Min. and max.	-1; 1
 
________________________________________
timebodygyrostdz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.88
1st and 3rd quartiles	-0.99; -0.34
Min. and max.	-1; 1
 
________________________________________
timebodygyrojerkmeanx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10295
Median	-0.1
1st and 3rd quartiles	-0.12; -0.08
Min. and max.	-1; 1
 
________________________________________
timebodygyrojerkmeany
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10299
Median	-0.04
1st and 3rd quartiles	-0.06; -0.03
Min. and max.	-1; 1
 
________________________________________
timebodygyrojerkmeanz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10298
Median	-0.05
1st and 3rd quartiles	-0.08; -0.03
Min. and max.	-1; 1
 
________________________________________
timebodygyrojerkstdx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10292
Median	-0.93
1st and 3rd quartiles	-0.99; -0.49
Min. and max.	-1; 1
 
________________________________________
timebodygyrojerkstdy
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10295
Median	-0.95
1st and 3rd quartiles	-0.99; -0.63
Min. and max.	-1; 1
 
________________________________________
timebodygyrojerkstdz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10291
Median	-0.95
1st and 3rd quartiles	-0.99; -0.51
Min. and max.	-1; 1
 
________________________________________
timebodyaccmagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.87
1st and 3rd quartiles	-0.98; -0.12
Min. and max.	-1; 1
 
________________________________________
timebodyaccmagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10294
Median	-0.84
1st and 3rd quartiles	-0.98; -0.24
Min. and max.	-1; 1
 
________________________________________
timegravityaccmagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.87
1st and 3rd quartiles	-0.98; -0.12
Min. and max.	-1; 1
 
________________________________________
timegravityaccmagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10294
Median	-0.84
1st and 3rd quartiles	-0.98; -0.24
Min. and max.	-1; 1
 
________________________________________
timebodyaccjerkmagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10292
Median	-0.95
1st and 3rd quartiles	-0.99; -0.3
Min. and max.	-1; 1
 
________________________________________
timebodyaccjerkmagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10294
Median	-0.93
1st and 3rd quartiles	-0.99; -0.27
Min. and max.	-1; 1
 
________________________________________
timebodygyromagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10298
Median	-0.82
1st and 3rd quartiles	-0.98; -0.25
Min. and max.	-1; 1
 
________________________________________
timebodygyromagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10298
Median	-0.83
1st and 3rd quartiles	-0.98; -0.39
Min. and max.	-1; 1
 
________________________________________
timebodygyrojerkmagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10293
Median	-0.96
1st and 3rd quartiles	-0.99; -0.55
Min. and max.	-1; 1
 
________________________________________
timebodygyrojerkmagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	-0.94
1st and 3rd quartiles	-0.99; -0.61
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccmeanx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10295
Median	-0.95
1st and 3rd quartiles	-0.99; -0.26
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccmeany
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10292
Median	-0.86
1st and 3rd quartiles	-0.98; -0.1
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccmeanz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10295
Median	-0.9
1st and 3rd quartiles	-0.98; -0.37
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccstdx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10294
Median	-0.94
1st and 3rd quartiles	-0.99; -0.25
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccstdy
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	-0.83
1st and 3rd quartiles	-0.98; -0.09
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccstdz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.84
1st and 3rd quartiles	-0.98; -0.3
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccjerkmeanx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10293
Median	-0.95
1st and 3rd quartiles	-0.99; -0.33
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccjerkmeany
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.93
1st and 3rd quartiles	-0.98; -0.26
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccjerkmeanz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10294
Median	-0.95
1st and 3rd quartiles	-0.99; -0.51
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccjerkstdx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10291
Median	-0.96
1st and 3rd quartiles	-0.99; -0.32
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccjerkstdy
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10294
Median	-0.93
1st and 3rd quartiles	-0.99; -0.24
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccjerkstdz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10290
Median	-0.96
1st and 3rd quartiles	-0.99; -0.59
Min. and max.	-1; 1
 
________________________________________
frequencybodygyromeanx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	-0.89
1st and 3rd quartiles	-0.99; -0.38
Min. and max.	-1; 1
 
________________________________________
frequencybodygyromeany
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.92
1st and 3rd quartiles	-0.98; -0.47
Min. and max.	-1; 1
 
________________________________________
frequencybodygyromeanz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	-0.89
1st and 3rd quartiles	-0.99; -0.32
Min. and max.	-1; 1
 
________________________________________
frequencybodygyrostdx
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	-0.91
1st and 3rd quartiles	-0.99; -0.52
Min. and max.	-1; 1
 
________________________________________
frequencybodygyrostdy
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10293
Median	-0.91
1st and 3rd quartiles	-0.98; -0.44
Min. and max.	-1; 1
 
________________________________________
frequencybodygyrostdz
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10295
Median	-0.89
1st and 3rd quartiles	-0.99; -0.42
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccmagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.88
1st and 3rd quartiles	-0.98; -0.22
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccmagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10298
Median	-0.85
1st and 3rd quartiles	-0.98; -0.38
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccjerkmagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10290
Median	-0.93
1st and 3rd quartiles	-0.99; -0.26
Min. and max.	-1; 1
 
________________________________________
frequencybodyaccjerkmagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.93
1st and 3rd quartiles	-0.99; -0.31
Min. and max.	-1; 1
 
________________________________________
frequencybodygyromagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10297
Median	-0.88
1st and 3rd quartiles	-0.98; -0.45
Min. and max.	-1; 1
 
________________________________________
frequencybodygyromagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10296
Median	-0.83
1st and 3rd quartiles	-0.98; -0.47
Min. and max.	-1; 1
 
________________________________________
frequencybodygyrojerkmagmean
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10293
Median	-0.95
1st and 3rd quartiles	-0.99; -0.61
Min. and max.	-1; 1
 
________________________________________
frequencybodygyrojerkmagstd
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	10292
Median	-0.94
1st and 3rd quartiles	-0.99; -0.64
Min. and max.	-1; 1
 
________________________________________
Report generation information:
.	Created by PDWMSA (username: pdaly).
.	Report creation time: Wed Oct 10 2018 09:09:19
.	Report was run from directory: C:/Users/pdaly/Documents
.	dataMaid v1.2.0 [Pkg: 2018-10-03 from CRAN (R 3.5.1)]
.	R version 3.5.0 (2018-04-23).
.	Platform: x86_64-w64-mingw32/x64 (64-bit)(Windows 7 x64 (build 7601) Service Pack 1).
.	Function call: makeDataReport(data = Combined_data_set, mode = c("summarize",  "visualize", "check"), smartNum = FALSE, file = "codebook_Combined_data_set.Rmd",  checks = list(character = "showAllFactorLevels", factor = "showAllFactorLevels",      labelled = "showAllFactorLevels", haven_labelled = "showAllFactorLevels",      numeric = NULL, integer = NULL, logical = NULL, Date = NULL),  listChecks = FALSE, maxProbVals = Inf, codebook = TRUE, reportTitle = "Codebook for Combined_data_set")

---------------------------------

Codebook for TidyAvgSubjectFeature:

Autogenerated data summary from dataMaid
2018-10-10 09:06:30
Data report overview
The dataset examined has the following dimensions:
Feature	Result
Number of observations	11880
Number of variables	4
Codebook summary table
Label	Variable	Class	# unique values	Missing	Description
	subject
integer	30	0.00 %	
	activity
character	6	0.00 %	
	feature
character	66	0.00 %	
	average
numeric	11520	0.00 %	
Variable list
subject
Feature	Result
Variable type	integer
Number of missing obs.	0 (0 %)
Number of unique values	30
Median	15.5
1st and 3rd quartiles	8; 23
Min. and max.	1; 30
 
________________________________________
activity
Feature	Result
Variable type	character
Number of missing obs.	0 (0 %)
Number of unique values	6
Mode	"LAYING"
 
.	Observed factor levels: "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS".
________________________________________
feature
Feature	Result
Variable type	character
Number of missing obs.	0 (0 %)
Number of unique values	66
Mode	"frequencybodyaccjerkmagmean"
 
.	Observed factor levels: "frequencybodyaccjerkmagmean", "frequencybodyaccjerkmagstd", "frequencybodyaccjerkmeanx", "frequencybodyaccjerkmeany", "frequencybodyaccjerkmeanz", "frequencybodyaccjerkstdx", "frequencybodyaccjerkstdy", "frequencybodyaccjerkstdz", "frequencybodyaccmagmean", "frequencybodyaccmagstd", "frequencybodyaccmeanx", "frequencybodyaccmeany", "frequencybodyaccmeanz", "frequencybodyaccstdx", "frequencybodyaccstdy", "frequencybodyaccstdz", "frequencybodygyrojerkmagmean", "frequencybodygyrojerkmagstd", "frequencybodygyromagmean", "frequencybodygyromagstd", "frequencybodygyromeanx", "frequencybodygyromeany", "frequencybodygyromeanz", "frequencybodygyrostdx", "frequencybodygyrostdy", "frequencybodygyrostdz", "timebodyaccjerkmagmean", "timebodyaccjerkmagstd", "timebodyaccjerkmeanx", "timebodyaccjerkmeany", "timebodyaccjerkmeanz", "timebodyaccjerkstdx", "timebodyaccjerkstdy", "timebodyaccjerkstdz", "timebodyaccmagmean", "timebodyaccmagstd", "timebodyaccmeanx", "timebodyaccmeany", "timebodyaccmeanz", "timebodyaccstdx", "timebodyaccstdy", "timebodyaccstdz", "timebodygyrojerkmagmean", "timebodygyrojerkmagstd", "timebodygyrojerkmeanx", "timebodygyrojerkmeany", "timebodygyrojerkmeanz", "timebodygyrojerkstdx", "timebodygyrojerkstdy", "timebodygyrojerkstdz", "timebodygyromagmean", "timebodygyromagstd", "timebodygyromeanx", "timebodygyromeany", "timebodygyromeanz", "timebodygyrostdx", "timebodygyrostdy", "timebodygyrostdz", "timegravityaccmagmean", "timegravityaccmagstd", "timegravityaccmeanx", "timegravityaccmeany", "timegravityaccmeanz", "timegravityaccstdx", "timegravityaccstdy", "timegravityaccstdz".
________________________________________
average
Feature	Result
Variable type	numeric
Number of missing obs.	0 (0 %)
Number of unique values	11520
Median	-0.58
1st and 3rd quartiles	-0.93; -0.11
Min. and max.	-1; 0.97
 
________________________________________
Report generation information:
.	Created by PDWMSA (username: pdaly).
.	Report creation time: Wed Oct 10 2018 09:06:31
.	Report was run from directory: C:/Users/pdaly/Documents
.	dataMaid v1.2.0 [Pkg: 2018-10-03 from CRAN (R 3.5.1)]
.	R version 3.5.0 (2018-04-23).
.	Platform: x86_64-w64-mingw32/x64 (64-bit)(Windows 7 x64 (build 7601) Service Pack 1).
.	Function call: makeDataReport(data = TidyAvgSubjectFeature, mode = c("summarize",  "visualize", "check"), smartNum = FALSE, file = "codebook_TidyAvgSubjectFeature.Rmd",  checks = list(character = "showAllFactorLevels", factor = "showAllFactorLevels",      labelled = "showAllFactorLevels", haven_labelled = "showAllFactorLevels",      numeric = NULL, integer = NULL, logical = NULL, Date = NULL),  listChecks = FALSE, maxProbVals = Inf, codebook = TRUE, reportTitle = "Codebook for TidyAvgSubjectFeature")

