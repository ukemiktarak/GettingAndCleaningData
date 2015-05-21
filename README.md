run_analysis.R
==========
	by: UKemiktarak
==========
	R script for extraction and aggregation of "Human Activity Recognition Using Smartphones Dataset". This script merges the training and the test sets to create one data set. It then extracts only the measurements on the mean and standard deviation for each measurement and creates a second, independent tidy data set with the average of each variable for each activity and each subject. The generated dataset is then written into txt file with the name "run_analysis.txt". 

	Script should be placed under the same folder as the  main dataset folder (UCI HAR Dataset). 
	
	Run main() from R command after sourcing (source("run_analysis.R")) the script. Working directory must be the same as the main dataset folder (setwd("<FOLDER_PATH>/UCI HAR Dataset")) 
	
ALGORITHM
==========
	1- Merge test and train data sets
	2- Extract mean and standard deviation columns for each subject and activity label
	3- Calculate the average of each variable for each  activity and each subject and create a tidy data set
	4- Write the new dataset to a file

FUNCTIONS
==========
	1- mergeFiles:  
	Function reads X_train.txt, y_train.txt, subject_train.txt under train folder and  X_test.txt, y_test.txt, subject_trest.txt  under test folder and merges all 6 files.  It then reads features.txt to pull variable/column names and renames the columns of merged dataframe. It removes dashes (-) and parentheses (()) before naming the columns. Returns the newly created dataframe.
	Parameters: N/A
	
	2- extractMnStdColumns: 
	Function returns a data frame that has only the std and mean columns.
	Parameters: Dataframe (df) 
	
	3- aggregateData:
	Function creates a tidy dataset  with the average of each variable for each activity and each subject and returns it as a dataframe.
	Parameters: Dataframe (df) 
	
	4- writeToFile:
	Function writes contents of a dataframe to a file with the name run_analysis.txt
	Parameters: Dataframe (df))
	
	5- main:
	Function should be called from the command to run the script.
	Parameters: N/A
	
CODE BOOK  (run_analysis.txt)
==========
	The variables in the generated data file:
	1- subject: subject number
	2- activity: activity label
	3- variable: variable/column name from the original dataset
	4- average: average value of  each variable for each activity and each subject