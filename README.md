Coursera - Getting and Cleaning Data:  Course Project
=====================================================

Introduction
------------
This repository contains the work I performed for the Coursera "Getting and Cleaning Data" course project.  This document contains
information about the different files found in this repository as well as an explanation on what tasks the R source script performs.

Legal
-----
Information on where this data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Per the publication requirements for the raw data, the following information is provided:

   Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support
   Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
   Vitoria-Gasteiz, Spain. Dec 2012


The Raw Data
------------
The purpose of this course project is to take the raw data located in the below URL, and to transform it into data that can be used
by R, or any other language or application that can read and use space delimited TXT files.  The raw data is is spread out
in multiple files, with data labels, separate test subject files, activity labels, and separate data files, provided disjointed in a zip file.

Data URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R Source Script
-------------------
The R source script run_analysis.R is used to download the data from the above URL, extract the contents of the zip file, transform
the data from it's raw state into a tidy TXT data file (HumanActivityDataSet*.txt) and an activity average TXT data file
(AverageDataSet*.txt).  The R script will produce a log file containing the steps taken to produce the tidy datasets along with a
time stamp on when the steps took place.  To reproduce the tidy datasets generated, simply load the source and execute the script:

```R
source("run_analysis.R")
run_analysis()
```

The run_analysis function is the entry point to the script and is referred to as the main script.  It in turn calls the downloadAndUnzip,
which downloads the raw dataset from the URL above and extracts the data from the zip file.  The main script will then call the
cleanDataSet function, which generates the first tidy dataset (HumanActivityDataSet*.txt).  The cleanDataSet function in turn will
call the following functions:

readAndBindSubject - for adding the subject file for both the Test and Train data.
readAndBindActivity - for adding the activity file for both the Test and Train data, providing the actual label for the activity preformed by the subject.
readAndBindSet - for adding the actual data measurements for both the Test and Train data. 

When the cleanDataSet completes, it will return a copy of the tidy data for the next function to use so that it doesn't have to load
the file from disk.  That next function that is called by the main run_analysis function is averageDataSet.  This function takes the 
data and simply determines the average (mean) of all the identical activities for the subjects and produces the average tidy data set
(AverageDataSet*.txt).

Both tidy datasets contains a time stamp in the name to indicate when the file was generated.

The Code Book
-------------
The file Codebook.md contains information about the variables found in the Tidy Dataset.

The Tidy Dataset
-----------------
Two datasets are generated by the R source.  Please note that for both files, the asterisk denotes the time stamp of when
the file was generated.

HumanActivityDataSet*.txt - A tidy dataset which provides only the mean and standard deviation fields from the original raw data.  Note that all mean
	fields are included since the instructions did not indicate if meanFreq should be included or not.  It simply states that "all" means and
	standard deviation fields should be included.
	
AverageDataSet*.txt - A tidy dataset which provides "the average of each variable for each activity and each subject."  The column names for each
	field is identical to the HumanActivityDataSet*.txt, with the exception that all measurement fields start with "ActivityMean-" indicating the 
	purpose of this new dataset.

The Log File
------------
The included file "logfile_*timestamp*.txt" was generated during the download and generation of the tidy dataset files.  In Data Science we are required to record the steps we took as well as when they were taken.  This log file is a recording of the steps taken by the R script file and when they were taken.
