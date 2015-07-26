#Getting and Cleaning Data

##Course Project

This is the course project for the module Getting and Cleaning Data, of the [Data Analysis Track](https://www.coursera.org/specializations/jhudatascience/1) from [Johns Hopkins University](https://www.jhu.edu/), hosted on [Coursera](https://www.coursera.org/).

###Overview

The purpose of this project is to demonstrate an ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

One of the most exciting areas in all of data science right now is wearable computing - see for example the article [Data Science, Wearable Computing and the Battle for the Throne as World’s Top Sports Brand](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

The project uses data from the Human Activity Recognition Using Smartphones Dataset Version 1.0. A full description is available at the site where the data was obtained: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

 A compressed file with all the data for the project was obtained from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.netgetdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Project Files

####README.md

This file

####run_analysis.R

This is the main R programming script for the project which does the following:

1. Combines the constituant project data files into a single data set
2. Subsets that data set to extract only the measurements of the mean and standard deviation for each measurement.
3. Uses the supplied look-up table to identify the activity type from a numerical code
4. Labels all the data variables
5. Creates and saves an independent, tidy, summary data set with the average of each variable for each activity and each subject.

Full details of the workings of this script are to be found in [CodeBook.md](CodeBook.md), section 5.

Note: this script can only be run as long as the Samsung data is in your working directory

####summary.txt

The summary data file created in step 12 of the R programming script `run_analysis.R`. This is a tidy data set with the average of each variable for each activity and each subject.

To load this file use `read.table("summary.txt", header = TRUE)` 

####CodeBook.md

This file contains the following:

1. Details of the Human Activity Recognition Using Smartphones Dataset
Version 1.0
2. Details of the downloaded data files from the experiment
3. Details of the observations that were recorded by the smartphone for every activity in the experiment
4. The look-up table for each acitivity
5. Details of how the run_analysis.R creates the `summary.txt` file

-----------------

Use of the data is licensed from:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
    
