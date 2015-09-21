## --------------------------------------------------------------------------
## Downloads, unzips and Cleans Data from fileUrl shown below
##  To use:
## source("run_analysis.R")
## run_analysis()
##
## Information on where this data was obtained:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## Publication information about the dataset being downloaded and cleaned:
##    Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
##    Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support
##    Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
##    Vitoria-Gasteiz, Spain. Dec 2012
##
## Developed for the Coursera "Getting and Cleaning Data" Course Project
## --------------------------------------------------------------------------



## --------------------------------------------------------------------------
## Entry point for downloading and cleaning data
## --------------------------------------------------------------------------
run_analysis <- function() {

	# get the date and time for use in file names
	# Example Format:  "Year_Month_Day_Hour_Minute"
	# Example Name: "2015_09_15_12_01"
	timeStamp <- format(Sys.time(), "_%Y_%m_%d_%H_%M")
	sessionFolder <- "HumanActivityData"

	# We are going to log the results of some steps, so we need a Global Variable log file name
	logFile <<- paste("./", sessionFolder, "/logfile", timeStamp, ".txt", sep = "")
	
	# If we have an error then we set this Global Variable to true so that we don't continue processing
	haveError <<- FALSE

	# Create the folder
	if (!file.exists(sessionFolder)) {
		dir.create(sessionFolder)
	}

	logWrite("Starting run_analysis")

	# download and unzip the raw data
	tryCatch( downloadAndUnzip(timeStamp, sessionFolder), error = function(e) { logWrite(e$message); haveError <<- TRUE })

	if (haveError == FALSE){
		# make the raw data clean and tidy
		tryCatch( dfOriginal <- cleanDataSet(timeStamp, sessionFolder), error = function(e) { logWrite(e$message); haveError <<- TRUE })
	}

	if (haveError == FALSE) {
		# generate the average data set
		tryCatch( averageDataSet(timeStamp, sessionFolder, dfOriginal), error = function(e) { logWrite(e$message); haveError <<- TRUE })
	}

	# log the final state
	if (haveError == TRUE) {
		logWrite("Failure - Exiting")
	}
	else{
		logWrite("Success - Done")
	}
	
	# remove the global environment variables
	rm(logFile, pos = ".GlobalEnv")
	rm(haveError, pos = ".GlobalEnv")
}


## --------------------------------------------------------------------------
## This function downloads the data from the website and unzips the file
## --------------------------------------------------------------------------
downloadAndUnzip <- function(timeStamp, targetFolder) {

	# The source and target names for downloading the file
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	destFile <- paste("./", targetFolder, "/UCI HAR Dataset", timeStamp, ".zip", sep = "")

	logWrite("Download File")
	# Mac Download Command - comment out the windows version and use this if running on Mac
	#download.file(fileUrl, destfile = destFile, method = "curl")

	# Windows Download Command 
	download.file(fileUrl, destfile = destFile)

	# log the date we downloaded the file
	dateDownload <- date()
	logWrite(paste("Downloaded File on ", dateDownload, sep = ""))

	# unzip the downloaded file
	logWrite(paste("Unzip File: ", destFile, sep = ""))
	unzipInfo <- unzip(destFile, overwrite = TRUE, exdir = paste(".", targetFolder, sep = "/"), setTimes = TRUE)
	logWrite(unzipInfo)
}


## --------------------------------------------------------------------------
## This function cleans the downloaded data
## --------------------------------------------------------------------------
cleanDataSet <- function(timeStamp, sessionFolder){

	logWrite("Start Cleaning the Data")
	# set the locations for each folder raw and tidy
	rawDataFolder =  paste(".", sessionFolder, "UCI HAR Dataset", sep = "/")
	tidyDataFolder = paste(".", sessionFolder, "Tidy", sep = "/")

	# log the location of each raw and tidy folder
	logWrite(paste("rawDataFolder = ", rawDataFolder, sep = ""))
	logWrite(paste("tidyDataFolder = ", tidyDataFolder, sep = ""))

	# define all the raw data file names

	# for Subject ID
	subjectTestFileName <- paste(rawDataFolder, "test/subject_test.txt", sep = "/")
	subjectTrainFileName <- paste(rawDataFolder, "train/subject_train.txt", sep = "/")

	# for Activity Label
	activityTestFileName <- paste(rawDataFolder, "test/y_test.txt", sep = "/")
	activityTrainFileName <- paste(rawDataFolder, "train/y_train.txt", sep = "/")

	# for Labels of Activity
	activityLabelsFileName <- paste(rawDataFolder, "activity_labels.txt", sep = "/")
	
	# for Labels of Column Names
	headerLabelsFileName <- paste(rawDataFolder, "features.txt", sep = "/")

	# for Set
	setTestFileName <- paste(rawDataFolder, "test/X_test.txt", sep = "/")
	setTrainFileName <- paste(rawDataFolder, "train/X_train.txt", sep = "/")

	#read the subject files
	dfTest <- readAndBindSubject(subjectTestFileName)
	dfTrain <- readAndBindSubject(subjectTrainFileName)

	# read the activity label file
	logWrite(paste("Reading Activity Labels From", activityLabelsFileName, sep = " "))
	activityLabels <- read.table(activityLabelsFileName, header = FALSE)
	
	# read the activity files
	dfTest <- readAndBindActivity(dfTest, activityTestFileName, activityLabels)
	dfTrain <- readAndBindActivity(dfTrain, activityTrainFileName, activityLabels)

	# read in the header labels of the measurements
	logWrite(paste("Reading Measurement Header Labels From", headerLabelsFileName, sep = " "))
	headerLabels <- read.table(headerLabelsFileName, header = FALSE)
	columnNames <- vector()
	meanStdNames <- vector()
	
	# clean the header labels of the measurements
	for (ix in 1:nrow(headerLabels)){
		theName <- as.character(headerLabels[ix,2])
		theLower <- tolower(theName)		
		
		#scrub the header labels for a nice and clean look - remove "(", ")", ","
		if(grepl("angle\\(", theLower))
			theName <- gsub("\\(", "-", theName)
		else
			theName <- gsub("\\(", "", theName)

		theName <- gsub("\\)", "", theName)
		theName <- gsub(",", "-", theName)

		columnNames <- cbind(columnNames, theName)
		
		if(grepl("mean", theLower) || grepl("std", theLower)){
				meanStdNames <- cbind(meanStdNames, theName)
		}
	}

	# read the Set files and bind the mean and standard deviation to the data frames
	dfTest <- readAndBindSet(dfTest, setTestFileName, columnNames, meanStdNames)
	dfTrain <- readAndBindSet(dfTrain, setTrainFileName, columnNames, meanStdNames)

	#combine both test and train data sets
	dfBig <- rbind(dfTest, dfTrain)

	if (!file.exists(tidyDataFolder)) {
		dir.create(tidyDataFolder)
	}

	bigFileOut <- paste(tidyDataFolder, "/HumanActivityDataSet", timeStamp, ".csv", sep = "")

	# write the main big data to a tidy file
	logWrite(paste("Writing Tidy data to ", bigFileOut))
	write.csv(dfBig, bigFileOut, row.names = FALSE)

	# return the final data set so that it can be used by other functions.
	# no need to load in the data again if it's already in memory
	dfBig
}


## --------------------------------------------------------------------------
## Creates a second data set containing the average values for each
## activity and subject
## --------------------------------------------------------------------------
averageDataSet <- function(timeStamp, sessionFolder, dfOriginal){

	logWrite("Generate Dataset with Average for each activity and each subject")
	library(plyr)

	# set the locations for each folder raw and tidy
	tidyDataFolder <- paste(".", sessionFolder, "Tidy", sep = "/")
	averageFileOut <- paste(tidyDataFolder, "/AverageDataSet", timeStamp, ".csv", sep = "")
	
	# limit the means to just the columns we need, so all but 1 and 2
	theMeansColumns <- function(dataIn) { colMeans(dataIn[,-c(1,2)]) }
	
	logWrite("Build the new data set")
	dfActivity <- ddply(dfOriginal, .(SubjectID,Activity), theMeansColumns)

	# set the column names
	colnames(dfActivity) <- colnames(dfOriginal)
	names(dfActivity)[-c(1,2)] <- paste0("ActivityMean-", names(dfActivity)[-c(1,2)])

	logWrite("Finished creating new dataset")

	# write the new dataset to a tidy file
	logWrite(paste("Writing New Dataset to ", averageFileOut))
	write.csv(dfActivity, averageFileOut, row.names = FALSE)
}


## --------------------------------------------------------------------------
## Reads the Subject Data, processes it, and returns the new data frame
## --------------------------------------------------------------------------
readAndBindSubject <- function(subjectFileName){
	#read the subject files
	logWrite(paste("Adding SubjectID From", subjectFileName, sep = " "))
	subjectIn <- read.table(subjectFileName, sep = " ", header = FALSE)

	# return the read values
	subjectIn[,1]
}


## --------------------------------------------------------------------------
## Reads the Activity Data, processes it, binds it with the given data frame
## and returns the new data frame
## --------------------------------------------------------------------------
readAndBindActivity <- function(dfIn, activityFileName, activityLabels){
	# read the activity files
	logWrite(paste("Adding Activity From", activityFileName, sep = " "))
	activityIn <- read.table(activityFileName, sep = " ", header = FALSE)

	# replace the activity numeric values with activity labels
	for (ix in 1:nrow(activityIn)) {
		for (iy in 1:nrow(activityLabels)) {
			if (activityIn[ix,1]==activityLabels[iy,1]) {
				activityIn[ix,1] <-  as.character(activityLabels[iy,2])
			}
		}
	}

	# bind the activity to the data frames
	dfOut <- cbind(dfIn, activityIn)
	
	# set the column names to the both datasets test and train for what we currently have
	colnames(dfOut) <- c("SubjectID","Activity")
	dfOut
}


## --------------------------------------------------------------------------
## Reads the Set Data, processes it, binds it with the given data frame
## and returns the new data frame
## --------------------------------------------------------------------------
readAndBindSet <- function(dfIn, fileName, columnNames, meanStdNames){
	# read the file
	logWrite(paste("Adding Data From", fileName, sep = " "))
	dataX <- read.table(fileName, header = FALSE)
	
	# set the column names
	colnames(dataX) <- columnNames
	cbind(dfIn, dataX[,meanStdNames])
}


## --------------------------------------------------------------------------
## Called to write information to a log file as well as to the console
## Logs will include a time stamp as to when the message was written
## --------------------------------------------------------------------------
logWrite <- function(messageIn){
	now <- format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z | ")
	newMessage <- paste(now, messageIn, sep = "")
	consoleMessage <- paste(newMessage, "\n", sep = "")
	cat(consoleMessage)
	write(newMessage, file = logFile, append = TRUE)
}