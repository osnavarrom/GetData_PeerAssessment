  Code-Book to "run_analysis.R" file
=================================================

This document contains a summary of the steps executed by the `run_analysis` 
function to process the data in the database "Human Activity Recognition Using 
Smartphones".  

* More information regarding the structure and origin of the data can be found at:

    [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

* The link through which the dataset was obtained is: 
    
    [Course data link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
  
* The run_analysis.R script performs the following steps to clean the data:  

 1. Read `features.txt` and took the variables names. Adding `Activity` and `Subject` 
 labels to `varLabels` vector.
 
 2. Read `X_train.txt`, `subject_train.txt` and `y_train.txt` from the 
 `./UCI_HAR_Dataset` folder and store them in `trainData`, `subjectTrain` and 
 `labelTrain` variables respectively. Creating the data set `trainData`.
 
 3. Read `X_test.txt`, `subject_test.txt` and `y_test.txt` from the 
 `./UCI_HAR_Dataset` folder and store them in `testData`, `subjectTest` and 
 `labelTest` variables respectively. Creating the data set `testData`.     
 
 4. Join `testData` to `trainData` in a 10299 X 561 data frame, called 
 `totalDataSet`.  
 
 5. A new dataset that contains only such variables on its label containing the 
 expression `std` or expression `mean`, is extracted an stored in `selectData` 
 10299 X 88 data frame.  
 
 6. Through a loop are assigned to each activity a descriptive identifier like 
 to stored in the `activity_labels.txt` file. Converting the `Activity` variable 
 as a factor.
  
 7. A new label for each variable is created by placing the `AVG` prefix to the 
 names from the original data sets. (i.e `AVG.tBodyAcc.std...X`)
 
 8. Cread a `tidyData.txt` file, with summary and tidy data requested and print a
 message confirming the completion of the process.
