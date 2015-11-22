
#Data Sources

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Data Transformation


   0. Download dataset files and unzip

   0.1 Create dedicated "data"" repository into working director
   0.2 Download zip file if not already done and unzip

   1. Merges the training and the test sets to create one data set
   
   1.1 Define files ditinct paths (one for unzipped directory, one for train and test data sets)
   
   1.2 Get features names and convert into a vector of column names (featureNames)

   1.3 Get train files into 3 data tables (data_subject, data_x and data_y) then merge them with cbind function to obtain data_train
   1.4 Get test files into 3 data tables (data_subject, data_x and data_y) then merge them with cbind function to obtain data_test
   1.5 Combine test and train data tables, rename column names with featureNames

   ##------------------------------------------------------------------------------------------
   ## 2. Extracts only the measurements on the mean and standard deviation for each measurement
   ## Tip: keep subject and activity columns
   ##------------------------------------------------------------------------------------------
   
   ## I ignore "angle(...,...Mean)" columns, considering result is an angle value not a mean
   ## And i exclclude "...meanFreq()" ones
   columnSubset <- grep("subject|activity|-mean\\(|-std\\(",names(data))
   data <- data[,columnSubset]
   
   ##--------------------------------------------------------------------------
   ## 3. Uses descriptive activity names to name the activities in the data set
   ##--------------------------------------------------------------------------
   
   ## 3.1 Get activity labels and convert into a vector of activity labels

      3.2 Convert activity values to activity labels

   4. Appropriately labels the data set with descriptive variable names
   
      4.1 Replace existing chains by more literal ones
   
   5. From the data set in step 4, creates a second, independent tidy data set 
   with the average of each variable for each activity and each subject
      
      5.1 Generate new data set using reshpae functions melt and cast
      5.2 Create .txt file from new data set

#Data Structure

Field #1:

 [1] "subject" 

Fields #2-67:
                                                                
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

[68] "activity"