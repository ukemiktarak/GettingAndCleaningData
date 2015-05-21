library(dplyr)

## mergeFiles: reads test and train files and merges the data in a data frame,
##              reads the features.txt file and updates the column names 
##              of the new data frame from that file
mergeFiles <- function(){
    ## read files
    xtrn <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
    ytrn <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
    subjtrn <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
    
    xtst <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors= FALSE)
    ytst <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors= FALSE)
    subjtst <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors= FALSE)
    
    ## merge train data frames
    trn <- cbind(subjtrn, ytrn, xtrn )
    ## merge test data frames
    tst <- cbind(subjtst, ytst, xtst )
    
    ## read column names
    cnames <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors= FALSE)
    ## add subject and activity label column names
    cnames <- append(c("subject", "activity"), cnames[, 2])
    ## remove parentheses
    cnames <- gsub("\\(\\)", "", cnames)
    ## replace dashes with underscores
    cnames <- gsub("-", "_", cnames)
    
    ## merge files
    xtotal <- rbind(trn, tst)
    
    ## update column names of the dataframe 
    colnames(xtotal) <- cnames
    
    xtotal
}

## extractMnStdColumns: returns a data frame that has only the std and mean columns
extractMnStdColumns <- function(df){
    ## get the column numbers that have mean and std values
    colsToExtract <- grep("subject|activity|mean|std", colnames(df))
    ## extract columns
    retDf <- df[,colsToExtract]
    
    retDf
}

## aggregateData: creates a data set with the average of each variable
##                   for each activity and each subject
aggregateData <- function (df){
    retAggrData <- data.frame()
    trnsDf <- data.frame()
    ## list for to-be-ignored columns 
    nextList <- c("subject", "activity")
    ## create a new data frame with the variables (columns)
    ##  as new values (transpose the frame)
    
    for(colName in colnames(df)){
        ## if it is subject or activity column skip
        if(colName %in% nextList){
            next()
        }   

        trnsDf <- rbind(trnsDf, cbind(df[,1], df[,2], colName, df[,colName]))
    }
    ## rename variables
    colnames(trnsDf) <- c("subject", "activity", "variable", "value") 
    ## trnsDf
    
    ## run the aggregate counts:
    gp <- group_by(trnsDf, subject, activity, variable)
    retAggrData <- summarize(gp, mean(value))
    ## rename columns
    colnames(retAggrData) <- c("subject", "activity", "variable", "average")
    retAggrData
}

## writeToFile: writes contents of a dataframe to a file with the name run_analysis.txt
writeToFile <- function(df){
    fileName <-"run_analysis.txt"
    write.table(df, file=fileName, quote=FALSE, row.names=FALSE, col.names=FALSE)
}

## main: main function that runs to process the data
main <- function (){
    ## merge data files
    df <- mergeFiles()
    ## filter out only the std and mean columns from the merged data
    df <- extractMnStdColumns(df)
    
    ## get mean of all values by subject, activity/label and column(variable)
    aggDf <- aggregateData(df)
    
    ## write the results to run_analysis.txt
    writeToFile(aggDf)
}
