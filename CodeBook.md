#Data description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'second_data_set.txt': tidy data set for "Getting and Cleaning Data - Course Project" (see README.md file)

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

#Data Transformation

reshape2 library is required

The run_analysis.R script used to manipulate data sources is composed of the following steps:

##Step 0: Download dataset files and unzip

- Step 0.1: Create dedicated "data"" repository into working directory
- Step 0.2: Download zip file (if not already done) and unzip
   
##Step 1: Merge the training and the test sets to create one data set

- Step 1.1: Define files ditinct paths (one for unzipped directory, one for each train and test data sets directories)
```
   rootPath <- "./data/UCI HAR Dataset"
   trainPath <- file.path(rootPath,"train")
   testPath <- file.path(rootPath,"test")
```
- Step 1.2: Get features names (from features.txt file) and convert into a vector of column names (featureNames)
```
   fileName <- "features.txt"
   filePath <- file.path(rootPath,fileName)
   data_features <- read.table(filePath)
   featuresNames <- as.vector(data_features[,2])
   featuresNames <- c("subject",featuresNames,"activity")
```
- Step 1.3: Get train files (subject_train.txt, X_train.txt and y_train.txt) into 3 data tables (data_subject, data_x and data_y)
```
   fileName <- "subject_train.txt"
   filePath <- file.path(trainPath,fileName)
   data_subject <- read.table(filePath)
   
   fileName <- "X_train.txt"
   filePath <- file.path(trainPath,fileName)
   data_x <- read.table(filePath)
  
   fileName <- "y_train.txt"
   filePath <- file.path(trainPath,fileName)
   data_y <- read.table(filePath)
```
   Then merge them with cbind function to obtain data_train table:
```
   data_train <- cbind(data_subject,data_x,data_y)
```   
- Step 1.4: Get test files (subject_test.txt, X_test.txt and y_test.txt) into 3 data tables (data_subject, data_x and data_y), then merge them with cbind function to obtain data_test table (idem step 1.3)

- Step 1.5: Combine test and train data tables into one table (data), rename column names with featureNames (step 1.2)
```  
   data <- rbind(data_train,data_test)
   names(data) <- featuresNames
```  
## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
   
- Reshape data table, using grep function applied on data table names,  ignoring "angle(...,...Mean)" columns (considering result is an angle value not a mean) and exclcluding "...meanFreq()" values
``` 
   columnSubset <- grep("subject|activity|-mean\\(|-std\\(",names(data))
   data <- data[,columnSubset]
``` 
- Then update featureNames from data table (reshaped) names
``` 
   featuresNames <- names(data)
``` 

## Step 3: Uses descriptive activity names to name the activities in the data set

- Step 3.1: Get activity labels from activity_labels.txt and convert into a vector of activity labels (activityLabels)
``` 
   fileName <- "activity_labels.txt"
   filePath <- file.path(rootPath,fileName)
   data_activityLabels <- read.table(filePath)
   activityLabels <- as.vector(data_activityLabels[,2])
``` 
- Step 3.2: Convert data table activity values into factor values using activityLabels
``` 
   data[,"activity"] <- factor(data[,"activity"],levels=1:6,labels=activityLabels)
``` 
## Step 4: Appropriately labels the data set with descriptive variable names
   
- Replace existing names by more literal ones using gsub function applied on featureNames
``` 
   featuresNames <- gsub("[()]","",featuresNames)
   featuresNames <- gsub("-X",".Axis.X",featuresNames)
   featuresNames <- gsub("-Y",".Axis.Y",featuresNames)
   featuresNames <- gsub("-Z",".Axis.Z",featuresNames)
   featuresNames <- gsub("-mean",".Mean",featuresNames)
   featuresNames <- gsub("-std",".StandardDeviation",featuresNames)
   featuresNames <- gsub("meanFreq",".Mean.Frequency",featuresNames)
   featuresNames <- gsub("Mag",".Magnitude",featuresNames)
   featuresNames <- gsub("Jerk",".Jerk",featuresNames)
   
   featuresNames <- gsub("Acc",".Accelerometer",featuresNames)
   featuresNames <- gsub("Gyro",".Gyroscope",featuresNames)
   featuresNames <- gsub("BodyBody","Body",featuresNames)
   featuresNames <- gsub("Body",".Body",featuresNames)
   featuresNames <- gsub("Gravity",".Gravity",featuresNames)
   
   featuresNames <- gsub("f\\.","TransformedSignal.",featuresNames)
   featuresNames <- gsub("t\\.","Signal.",featuresNames)
``` 
- Update data table names with featureNames
``` 
   names(data) <- featuresNames
```

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
      
- Step 5.1: Generate new data set using reshape functions melt and cast, in order to compute mean of all measurements for each activity and each subject
```
   meltData <- melt(data,id=c("subject","activity"))
   newData <- cast(meltData,subject+activity~variable,mean)
```
- Step 5.2: Create .txt file from new data set
```
   fileName <- "second_data_set.txt"
   filePath <- file.path(rootPath,fileName)
   
   write.table(newData,file=filePath,row.names=FALSE,eol="\r\n")
```

#Data Structure

Field #1:

 [1] "subject": integer from 1 to 30 representing subjects who carried observations

Field #2:

 [2] "activity": factor with values  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING,LAYING
Fields #2-67: all fields values are normalized
                                                                
 [3] "Signal.Body.Accelerometer.Mean.Axis.X"                                
 [4] "Signal.Body.Accelerometer.Mean.Axis.Y"                                
 [5] "Signal.Body.Accelerometer.Mean.Axis.Z"                                
 [6] "Signal.Body.Accelerometer.StandardDeviation.Axis.X"                   
 [7] "Signal.Body.Accelerometer.StandardDeviation.Axis.Y"                   
 [8] "Signal.Body.Accelerometer.StandardDeviation.Axis.Z"                   
 [9] "Signal.Gravity.Accelerometer.Mean.Axis.X"                             
[10] "Signal.Gravity.Accelerometer.Mean.Axis.Y"                             
[11] "Signal.Gravity.Accelerometer.Mean.Axis.Z"                             
[12] "Signal.Gravity.Accelerometer.StandardDeviation.Axis.X"                
[13] "Signal.Gravity.Accelerometer.StandardDeviation.Axis.Y"                
[14] "Signal.Gravity.Accelerometer.StandardDeviation.Axis.Z"                
[15] "Signal.Body.Accelerometer.Jerk.Mean.Axis.X"                           
[16] "Signal.Body.Accelerometer.Jerk.Mean.Axis.Y"                           
[17] "Signal.Body.Accelerometer.Jerk.Mean.Axis.Z"                           
[18] "Signal.Body.Accelerometer.Jerk.StandardDeviation.Axis.X"              
[19] "Signal.Body.Accelerometer.Jerk.StandardDeviation.Axis.Y"              
[20] "Signal.Body.Accelerometer.Jerk.StandardDeviation.Axis.Z"              
[21] "Signal.Body.Gyroscope.Mean.Axis.X"                                    
[22] "Signal.Body.Gyroscope.Mean.Axis.Y"                                    
[23] "Signal.Body.Gyroscope.Mean.Axis.Z"                                    
[24] "Signal.Body.Gyroscope.StandardDeviation.Axis.X"                       
[25] "Signal.Body.Gyroscope.StandardDeviation.Axis.Y"                       
[26] "Signal.Body.Gyroscope.StandardDeviation.Axis.Z"                       
[27] "Signal.Body.Gyroscope.Jerk.Mean.Axis.X"                               
[28] "Signal.Body.Gyroscope.Jerk.Mean.Axis.Y"                               
[29] "Signal.Body.Gyroscope.Jerk.Mean.Axis.Z"                               
[30] "Signal.Body.Gyroscope.Jerk.StandardDeviation.Axis.X"                  
[31] "Signal.Body.Gyroscope.Jerk.StandardDeviation.Axis.Y"                  
[32] "Signal.Body.Gyroscope.Jerk.StandardDeviation.Axis.Z"                  
[33] "Signal.Body.Accelerometer.Magnitude.Mean"                             
[34] "Signal.Body.Accelerometer.Magnitude.StandardDeviation"                
[35] "Signal.Gravity.Accelerometer.Magnitude.Mean"                          
[36] "Signal.Gravity.Accelerometer.Magnitude.StandardDeviation"             
[37] "Signal.Body.Accelerometer.Jerk.Magnitude.Mean"                        
[38] "Signal.Body.Accelerometer.Jerk.Magnitude.StandardDeviation"           
[39] "Signal.Body.Gyroscope.Magnitude.Mean"                                 
[40] "Signal.Body.Gyroscope.Magnitude.StandardDeviation"                    
[41] "Signal.Body.Gyroscope.Jerk.Magnitude.Mean"                            
[42] "Signal.Body.Gyroscope.Jerk.Magnitude.StandardDeviation"               
[43] "TransformedSignal.Body.Accelerometer.Mean.Axis.X"                     
[44] "TransformedSignal.Body.Accelerometer.Mean.Axis.Y"                     
[45] "TransformedSignal.Body.Accelerometer.Mean.Axis.Z"                     
[46] "TransformedSignal.Body.Accelerometer.StandardDeviation.Axis.X"        
[47] "TransformedSignal.Body.Accelerometer.StandardDeviation.Axis.Y"        
[48] "TransformedSignal.Body.Accelerometer.StandardDeviation.Axis.Z"        
[49] "TransformedSignal.Body.Accelerometer.Jerk.Mean.Axis.X"                
[50] "TransformedSignal.Body.Accelerometer.Jerk.Mean.Axis.Y"                
[51] "TransformedSignal.Body.Accelerometer.Jerk.Mean.Axis.Z"                
[52] "TransformedSignal.Body.Accelerometer.Jerk.StandardDeviation.Axis.X"   
[53] "TransformedSignal.Body.Accelerometer.Jerk.StandardDeviation.Axis.Y"   
[54] "TransformedSignal.Body.Accelerometer.Jerk.StandardDeviation.Axis.Z"   
[55] "TransformedSignal.Body.Gyroscope.Mean.Axis.X"                         
[56] "TransformedSignal.Body.Gyroscope.Mean.Axis.Y"                         
[57] "TransformedSignal.Body.Gyroscope.Mean.Axis.Z"                         
[58] "TransformedSignal.Body.Gyroscope.StandardDeviation.Axis.X"            
[59] "TransformedSignal.Body.Gyroscope.StandardDeviation.Axis.Y"            
[60] "TransformedSignal.Body.Gyroscope.StandardDeviation.Axis.Z"            
[61] "TransformedSignal.Body.Accelerometer.Magnitude.Mean"                  
[62] "TransformedSignal.Body.Accelerometer.Magnitude.StandardDeviation"     
[63] "TransformedSignal.Body.Accelerometer.Jerk.Magnitude.Mean"             
[64] "TransformedSignal.Body.Accelerometer.Jerk.Magnitude.StandardDeviation"
[65] "TransformedSignal.Body.Gyroscope.Magnitude.Mean"                      
[66] "TransformedSignal.Body.Gyroscope.Magnitude.StandardDeviation"         
[67] "TransformedSignal.Body.Gyroscope.Jerk.Magnitude.Mean"                 
[68] "TransformedSignal.Body.Gyroscope.Jerk.Magnitude.StandardDeviation"
