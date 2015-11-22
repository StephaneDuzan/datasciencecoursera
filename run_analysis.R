run_analysis <- function() {
   
   ##------------------------------------
   ## 0. Download dataset files and unzip
   ##------------------------------------
   
   ## 0.1 Create dedicated data repository
   if (!file.exists("data")) {dir.create("data")}
   
   ## Name downloaded zip file
   fileName <- "Dataset.zip"
   filePath <- file.path("./data",fileName)
   
   ## 0.2 Download zip file if not already done and unzip
   if (!file.exists(filePath)) {
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(url=fileUrl,destfile=filePath,method="curl")
      unzip(filePath, overwrite=TRUE, exdir=".")
   }
   
   ##----------------------------------------------------------------
   ## 1. Merges the training and the test sets to create one data set
   ##----------------------------------------------------------------
   
   ## 1.1 Define files ditinct paths
   
   rootPath <- "./data/UCI HAR Dataset"
   trainPath <- file.path(rootPath,"train")
   testPath <- file.path(rootPath,"test")
   
   ## 1.2 Get features names and convert into a vector of column names
   
   fileName <- "features.txt"
   filePath <- file.path(rootPath,fileName)
   data_features <- read.table(filePath)
   featuresNames <- as.vector(data_features[,2])
   featuresNames <- c("subject",featuresNames,"activity")
   
   ## 1.3 Get train files into data tables

   fileName <- "subject_train.txt"
   filePath <- file.path(trainPath,fileName)
   data_subject <- read.table(filePath)
   
   fileName <- "X_train.txt"
   filePath <- file.path(trainPath,fileName)
   data_x <- read.table(filePath)
  
   fileName <- "y_train.txt"
   filePath <- file.path(trainPath,fileName)
   data_y <- read.table(filePath)
   
   data_train <- cbind(data_subject,data_x,data_y)
   
   ## 1.4 Get test files into data tables
   
   fileName <- "subject_test.txt"
   filePath <- file.path(testPath,fileName)
   data_subject <- read.table(filePath)
   
   fileName <- "X_test.txt"
   filePath <- file.path(testPath,fileName)
   data_x <- read.table(filePath)
   
   fileName <- "y_test.txt"
   filePath <- file.path(testPath,fileName)
   data_y <- read.table(filePath)
   
   data_test <- cbind(data_subject,data_x,data_y)
   
   ## 1.5 Combine test and train data tables, rename column names (based on step 1.2)
   data <- rbind(data_train,data_test)
   names(data) <- featuresNames
   
   ##------------------------------------------------------------------------------------------
   ## 2. Extracts only the measurements on the mean and standard deviation for each measurement
   ## Tip: keep subject and activity columns
   ##------------------------------------------------------------------------------------------
   
   ## I ignore "angle(...,...Mean)" columns, considering result is an angle value not a mean
   ## And i exclclude "...meanFreq()" ones
   columnSubset <- grep("subject|activity|-mean\\(|-std\\(",names(data))
   data <- data[,columnSubset]
   featuresNames <- names(data)
   
   ##--------------------------------------------------------------------------
   ## 3. Uses descriptive activity names to name the activities in the data set
   ##--------------------------------------------------------------------------
   
   ## 3.1 et activity labels and convert into a vector of activity labels
   fileName <- "activity_labels.txt"
   filePath <- file.path(rootPath,fileName)
   data_activityLabels <- read.table(filePath)
   activityLabels <- as.vector(data_activityLabels[,2])
   
   ## 3.2 Convert activity values to activity labels
   data[,"activity"] <- factor(data[,"activity"],levels=1:6,labels=activityLabels)
   
   ##---------------------------------------------------------------------
   ## 4. Appropriately labels the data set with descriptive variable names
   ##---------------------------------------------------------------------

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
   
   names(data) <- featuresNames
   
   ##----------------------------------------------------------------------------
   ## 5. From the data set in step 4, creates a second, independent tidy data set 
   ## with the average of each variable for each activity and each subject
   ##----------------------------------------------------------------------------
   
   ## 5.1 Generate new data set using reshpae functions melt and cast
   meltData <- melt(data,id=c("subject","activity"))
   newData <- cast(meltData,subject+activity~variable,mean)
   
   ## 5.2 Create .txt file from new data set
   fileName <- "second_data_set.txt"
   filePath <- file.path(rootPath,fileName)
   
   write.table(newData,file=filePath,row.names=FALSE,eol="\r\n")

   }