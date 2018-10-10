# GettingAndCleaningDataProject
PDWMSA

==================================================================
Tidy version of the original work: Human Activity Recognition Using Smartphones Dataset
See below for steps / detailed on the run_analysis script which is the crux of this work 
Version 1.0
==================================================================
Patrick Daly (PDWMSA)

Original work and data collection accredited to:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

run_analysis.R Script details:

-Original data pulled from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
-Packages employed: "readr", "dplyr", "tidyr" 
-The script works through the data to create a final tidy data set with the average of each feature for each subject and activity in this order:
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






The original data gathering:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

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

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
