# GetDataProject

## ReadMe file for Coursera Project

    

The script (run_analysis.R) takes the following files from the UCI HAR Dataset folder and merges them into one tidy dataset.         
There are a total of five steps to achieve this. All .txt files are listed below, and should be in the sub-directory "UCI HAR Dataset":
    

features.txt - This file provides descriptions for what the 561 columns in the xtest and xtrain files represent.
    
activity_labels.txt - This file provides descriptions of the six different activities that the subjects performed.   
subject_test.txt - This file provides the sequence of the 2947 test observations with respect to each observation's subject.
    
X_test.txt - This file contains the raw data of the 2947 test observations for 561 observed variables.
    
y_test.txt - Thie file provides the sequence of the 2947 test observations with respect to each observaton's activity.
    
subject_train.txt - This file provides the sequence of the 7352 train observations with respect to each observation's subject.
    
X_train.txt - This file contains the raw data of the 7352 train observations for 561 observed variables.
    
y_train.txt - Thie file provides the sequence of the 7352 train observations with respect to each observaton's activity.


Step 1A of the script - Imports seven of the .txt files into R. It also names the x-train and x-test data tables with all 561 variable names, and creates new columns for the subject and activity
indicators.
Step 1B on the script - Combines the test and train data sets into one data table. Gets the 561 column names ready to be modified in later steps.
We now have a total of 10,299 observations.

Step 2 of the script - Searches the 561 column names to isolate columns with the characters "ean" and "std", and removes all columns which don't have those characters.
We are only interested in the mean and standard deviation columns, and now have only 86 of such columns.

Step 3 of the script - Imports the activity_labels file into R and creates a new column "Activity" which describes which activity corresponds to that observation.

Step 4 of the script - Cleans up the column names by removing "BodyBody", unnecessary "...", and makes all instances of "mean" be lowercase.

Step 5 of the script - One line of code which reduces the 10,299 observations to 180 by averaging the observations based on:
	Subject: Levels 1 to 30
	Activity: Levels "Standing", "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Laying"
30 subjects * 6 activities = 180 observations (or rows). This data table is stored as "TidyMeans".

The output file of the script, step5.txt, is a data table containing 180 rows and 88 columns.