#Getting and Tidying Data

##Course Project

This is the project for the course Getting and Tidying Data, module 3 from the Data Analysis Track from Johns Hopkins University and hosted on Coursera.

###Overview

The purpose of this project is to demonstrate an ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The [License reference][1] for the data

###Project Files

####README.md

This file

####run_analysis.R

This is the main R programming script for the project which does the following:
1. Downloads and unzips the data files for the project
2. Combines the constituant data files into a single data set
3. Subsets that data set to extract only the measurements on the mean and standard deviation for each measurement.
4. Uses the supplied look-up table to identify the activity type from a numerical code
5. Labels all the data variables
6. Creates and saves a summary, independent tidy data set with the average of each variable for each activity and each subject.

Full details of the workings of this script are to be found in the file CodeBook.md

####summary.RData

The summary data file created in step 6 of the R programming script `run_analysis.R`. This is an independent tidy data set with the average of each variable for each activity and each subject.

To load this file `load("summary.RData")`

####CodeBook.md

This file contains the following details

- information about the variables in the data set
- information about the experimental study design
- details on each step in the `run_analysis.R` script for creating the tidy data set `summary.RData`

-----------------

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
    
