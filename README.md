#Getting and Cleaning Data - Course Project

##This analysis uses the Human Activity Recognition Using Smartphones Dataset V1.0

The purpose of this project is to demonstrate collecting, working with, and cleaning a data set. The result is a tidy data set that can be used for later analysis. 

Included is:  
1. a tidy data set as described below,  
2. a link to a Github repository with the script used for performing the analysis, and  
3. a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data called CodeBook.md.

##Description

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

Website: [UC Irvine Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here is the dataset used for the project: 

Dataset: [UCI Human Activity Recognition data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# Details of the R script called "run_analysis.R"

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
