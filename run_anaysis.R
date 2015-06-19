## Getting and Cleaning Data Course
## Peer-Assessment

## Oscar Saúl Navarro-Morato
## June 20, 2015.

run_analysis <- function(){

# To use call source("~/run_analysis.R") correcting for file location, then run_analysis()

# Load used libraries
    
    library(plyr)
    library(dplyr)

## Step 1. Merges the training and the test sets to create one data set.

## Reading and mixing the appropriate files to each dataset

#  It's assumed that the files are in the folder "UCI_HAR_Dataset"

    varNames <- read.table("./UCI_HAR_Dataset/features.txt", header = FALSE, 
                           sep = " ",stringsAsFactors = FALSE)
    varLabels <- c(varNames[, 2], "Activity", "Subject")

# Trainig data complete

    trainData <- read.table("./UCI_HAR_Dataset/train/X_train.txt", header = FALSE)
    subjectTrain <- read.table("./UCI_HAR_Dataset/train/subject_train.txt", 
                               header = FALSE)
    labelTrain<- read.table("./UCI_HAR_Dataset/train/y_train.txt", header = FALSE)

    trainData <- cbind(trainData, labelTrain, subjectTrain)
    names(trainData) <- varLabels


# Test data complete

    testData <- read.table("./UCI_HAR_Dataset/test/X_test.txt", header = FALSE)
    subjectTest <- read.table("./UCI_HAR_Dataset/test/subject_test.txt", 
                              header = FALSE)
    labelTest <- read.table("./UCI_HAR_Dataset/test/y_test.txt", header = FALSE)

    testData <- cbind(testData, labelTest, subjectTest)
    names(testData) <- varLabels

# Mixture of each dataset in one dataset

    totalDataSet <- rbind(trainData, testData) ## Complete dataset

    valid_column_names <- make.names(names = names(totalDataSet), unique=TRUE, 
                                     allow_ = TRUE)

# Assigning of valid labels for each variable

    names(totalDataSet) <- valid_column_names  


## Step 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement.

    selectData <- select(totalDataSet, matches("std()", ignore.case = TRUE), 
                        matches("mean()",ignore.case = TRUE), one_of("Activity", "Subject"))

## Step 3. Uses descriptive activity names to name the activities in the data set.

# Loop that assigns each activity a descriptive identifier
    
    i <- 1

    for (i in 1:10299)
    {
        if(selectData[i, 87] == 1)
        {
            selectData[i, 87] <- "Walking"
            i <- i + 1
        }
        if(selectData[i, 87] == 2)
        {
            selectData[i, 87] <- "Walk_Upstair"
            i <- i + 1
        }
        if(selectData[i, 87] == 3)
        {
            selectData[i, 87] <- "Walk_Downstair"
            i <- i + 1
        }
        if(selectData[i, 87] == 4)
        {
            selectData[i, 87] <- "Sitting"
            i <- i + 1
        }
        if(selectData[i, 87] == 5)
        {
            selectData[i, 87] <- "Standing"
            i <- i + 1
        }
        if(selectData[i, 87] == 6)
        {
            selectData[i, 87] <- "Laying"
            i <- i + 1
        }
    }

# Converting the variable "activity" as a factor

    selectData$Activity <- as.factor(selectData$Activity)


## Step 4. Appropriately labels the data set with descriptive variable names

    newNames <- names(selectData)

 # Initializing a vector with new variable names

    resNames <- c("")  

    for (i in 1:length(newNames) - 2)
    {
        resNames[i] <- paste0("AVG.", newNames[i])
        i <- i + 1
    }

# Complete new names

    tidyLabels <- c(resNames, "Activity", "Subject")
    

## Step 5. From the data set in step 4, creates a second, independent tidy dataset 
## with the average of each variable for each activity and each subject. 

    
# Generating tidy dataset with the average value of each variable, 
# for each subject and each activity

    summaryData <- selectData %>% group_by(Subject, Activity) 

    tidyData <- (summaryData %>%
                    summarise_each(funs(mean)) )
    
    names(tidyData) <- tidyLabels

# Writing the file ".txt"

    write.table(tidyData, file = "tidyData.txt")

    mnsg <- "Analysis carried out and file was written. You can view the file 
                contents below."

    print(mnsg)

    return(tydyData)
}