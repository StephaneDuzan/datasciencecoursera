#Data Sources

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Data Transformation

reshape2 library is required

The run_analysis.R script used to manipulate data sources is composed of the following steps:

##Step 0: Download dataset files and unzip

- Step 0.1: Create dedicated "data"" repository into working directory
- Step 0.2: Download zip file (if not already done) and unzip
   
##Step 1: Merge the training and the test sets to create one data set

- Step 1.1: Define files ditinct paths (one for unzipped directory, one for each train and test data sets directories)
- Step 1.2: Get features names (from features.txt file) and convert into a vector of column names (featureNames)
- Step 1.3: Get train files (subject_train.txt, X_train.txt and y_train.txt) into 3 data tables (data_subject, data_x and data_y), then merge them with cbind function to obtain data_train table
- Step 1.4: Get test files (subject_test.txt, X_test.txt and y_test.txt) into 3 data tables (data_subject, data_x and data_y), then merge them with cbind function to obtain data_test table
- Step 1.5: Combine test and train data tables into one table (data), rename column names with featureNames

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
   
- Reshape data table, using grep function applied on data table names,  ignoring "angle(...,...Mean)" columns (considering result is an angle value not a mean) and exclcluding "...meanFreq()" values
- Then update featureNames from data table (reshaped) names

## Step 3: Uses descriptive activity names to name the activities in the data set

- Step 3.1: Get activity labels from activity_labels.txt and convert into a vector of activity labels (activityLabels)
- Step 3.2: Convert data table activity values into factor values using activityLabels

## Step 4: Appropriately labels the data set with descriptive variable names
   
- Replace existing names by more literal ones using gsub function applied on featureNames
- Update data table names with featureNames
   
## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
      
- Step 5.1: Generate new data set using reshape functions melt and cast, in order to compute mean of all measurements for each activity and each subject
- Step 5.2: Create .txt file from new data set

#Data Structure

Field #1:

 [1] "subject": integer from 1 to 30 representing observations subjects

Fields #2-67: all fields values are normalized
                                                                
 [2] "Signal.Body.Accelerometer.Mean.Axis.X"                                   
 [3] "Signal.Body.Accelerometer.Mean.Axis.Y"                                   
 [4] "Signal.Body.Accelerometer.Mean.Axis.Z"                                   
 [5] "Signal.Body.Accelerometer.StandardDeviation.Axis.X"                      
 [6] "Signal.Body.Accelerometer.StandardDeviation.Axis.Y"                      
 [7] "Signal.Body.Accelerometer.StandardDeviation.Axis.Z"                      
 [8] "Signal.Gravity.Accelerometer.Mean.Axis.X"                                
 [9] "Signal.Gravity.Accelerometer.Mean.Axis.Y"                                
[10] "Signal.Gravity.Accelerometer.Mean.Axis.Z"                                
[11] "Signal.Gravity.Accelerometer.StandardDeviation.Axis.X"                   
[12] "Signal.Gravity.Accelerometer.StandardDeviation.Axis.Y"                   
[13] "Signal.Gravity.Accelerometer.StandardDeviation.Axis.Z"                   
[14] "Signal.Body.Accelerometer.Jerk.Mean.Axis.X"                              
[15] "Signal.Body.Accelerometer.Jerk.Mean.Axis.Y"                              
[16] "Signal.Body.Accelerometer.Jerk.Mean.Axis.Z"                              
[17] "Signal.Body.Accelerometer.Jerk.StandardDeviation.Axis.X"                 
[18] "Signal.Body.Accelerometer.Jerk.StandardDeviation.Axis.Y"                 
[19] "Signal.Body.Accelerometer.Jerk.StandardDeviation.Axis.Z"                 
[20] "Signal.Body.Gyroscope.Mean.Axis.X"                                       
[21] "Signal.Body.Gyroscope.Mean.Axis.Y"                                       
[22] "Signal.Body.Gyroscope.Mean.Axis.Z"                                       
[23] "Signal.Body.Gyroscope.StandardDeviation.Axis.X"                          
[24] "Signal.Body.Gyroscope.StandardDeviation.Axis.Y"                          
[25] "Signal.Body.Gyroscope.StandardDeviation.Axis.Z"                          
[26] "Signal.Body.Gyroscope.Jerk.Mean.Axis.X"                                  
[27] "Signal.Body.Gyroscope.Jerk.Mean.Axis.Y"                                  
[28] "Signal.Body.Gyroscope.Jerk.Mean.Axis.Z"                                  
[29] "Signal.Body.Gyroscope.Jerk.StandardDeviation.Axis.X"                     
[30] "Signal.Body.Gyroscope.Jerk.StandardDeviation.Axis.Y"                     
[31] "Signal.Body.Gyroscope.Jerk.StandardDeviation.Axis.Z"                     
[32] "Signal.Body.Accelerometer.Magnitude.Mean"                                
[33] "Signal.Body.Accelerometer.Magnitude.StandardDeviation"                   
[34] "Signal.Gravity.Accelerometer.Magnitude.Mean"                             
[35] "Signal.Gravity.Accelerometer.Magnitude.StandardDeviation"                
[36] "Signal.Body.Accelerometer.Jerk.Magnitude.Mean"                           
[37] "Signal.Body.Accelerometer.Jerk.Magnitude.StandardDeviation"              
[38] "Signal.Body.Gyroscope.Magnitude.Mean"                                    
[39] "Signal.Body.Gyroscope.Magnitude.StandardDeviation"                       
[40] "Signal.Body.Gyroscope.Jerk.Magnitude.Mean"                               
[41] "Signal.Body.Gyroscope.Jerk.Magnitude.StandardDeviation"                  
[42] "FastFourierTransform.Body.Accelerometer.Mean.Axis.X"                     
[43] "FastFourierTransform.Body.Accelerometer.Mean.Axis.Y"                     
[44] "FastFourierTransform.Body.Accelerometer.Mean.Axis.Z"                     
[45] "FastFourierTransform.Body.Accelerometer.StandardDeviation.Axis.X"        
[46] "FastFourierTransform.Body.Accelerometer.StandardDeviation.Axis.Y"        
[47] "FastFourierTransform.Body.Accelerometer.StandardDeviation.Axis.Z"        
[48] "FastFourierTransform.Body.Accelerometer.Jerk.Mean.Axis.X"                
[49] "FastFourierTransform.Body.Accelerometer.Jerk.Mean.Axis.Y"                
[50] "FastFourierTransform.Body.Accelerometer.Jerk.Mean.Axis.Z"                
[51] "FastFourierTransform.Body.Accelerometer.Jerk.StandardDeviation.Axis.X"   
[52] "FastFourierTransform.Body.Accelerometer.Jerk.StandardDeviation.Axis.Y"   
[53] "FastFourierTransform.Body.Accelerometer.Jerk.StandardDeviation.Axis.Z"   
[54] "FastFourierTransform.Body.Gyroscope.Mean.Axis.X"                         
[55] "FastFourierTransform.Body.Gyroscope.Mean.Axis.Y"                         
[56] "FastFourierTransform.Body.Gyroscope.Mean.Axis.Z"                         
[57] "FastFourierTransform.Body.Gyroscope.StandardDeviation.Axis.X"            
[58] "FastFourierTransform.Body.Gyroscope.StandardDeviation.Axis.Y"            
[59] "FastFourierTransform.Body.Gyroscope.StandardDeviation.Axis.Z"            
[60] "FastFourierTransform.Body.Accelerometer.Magnitude.Mean"                  
[61] "FastFourierTransform.Body.Accelerometer.Magnitude.StandardDeviation"     
[62] "FastFourierTransform.Body.Accelerometer.Jerk.Magnitude.Mean"             
[63] "FastFourierTransform.Body.Accelerometer.Jerk.Magnitude.StandardDeviation"
[64] "FastFourierTransform.Body.Gyroscope.Magnitude.Mean"                      
[65] "FastFourierTransform.Body.Gyroscope.Magnitude.StandardDeviation"         
[66] "FastFourierTransform.Body.Gyroscope.Jerk.Magnitude.Mean"                 
[67] "FastFourierTransform.Body.Gyroscope.Jerk.Magnitude.StandardDeviation"    

Field #68:

[68] "activity": factor with values  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING,LAYING
