# A simple script which completes the following:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and 
#       standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities 
#       in the data set
# 4. Appropriately labels the data set with descriptive variable 
#       names.
# 5. From the data set in step 4, creates a second, 
#       independent tidy data set with the average of 
        # each variable for each activity and each subject.

# This script assumes the correct working directory for the course
# project is active

# The dplyr library will be used
library(dplyr)

# STEP 1.
# read in the 2 common files to both sets: features and activities
# features will act as the column headings
# activities will act as a lookup table
data_folder <- "./UCI HAR Dataset/"

features <- read.table(paste0(data_folder, "features.txt"), as.is = c(TRUE, TRUE))
activities <- read.table(paste0(data_folder, "activity_labels.txt"))

# read in files from the test folder
folder <- "test"

test_x <- read.table(paste0(data_folder, folder, "/X_", folder, ".txt" ))
test_y <- read.table(paste0(data_folder, folder, "/y_", folder, ".txt" ))
test_s <- read.table(paste0(data_folder, folder, "/subject_", folder, ".txt" ))

# Assembly
# add column names
# to the X file
names(test_x) <- unlist(features[2])
# to the y file
names(test_y) <- "activity"
# to the s file
names(test_s) <- "id"

# and combine them all
test_all <- cbind(test_s, test_y, test_x)

# remove the old files to free up some memory
rm(test_x, test_y, test_s)

# ------------------------------------------

# read in files from the train folder
folder <- "train"

train_x <- read.table(paste0(data_folder, folder, "/X_", folder, ".txt" ))
train_y <- read.table(paste0(data_folder, folder, "/y_", folder, ".txt" ))
train_s <- read.table(paste0(data_folder, folder, "/subject_", folder, ".txt" ))

# Assembly
# add column names
# to the X file
names(train_x) <- unlist(features[2])
# to the y file
names(train_y) <- "activity"
# to the s file
names(train_s) <- "id"

# and combine them all
train_all <- cbind(train_s, train_y, train_x)

# remove the old files to free up some memory
rm(train_x, train_y, train_s)

# -------------------------------------------------

# combine the 2 data frames
data_all <- rbind(train_all, test_all)
# remove the old files to free up some memory
rm(train_all, test_all)

# -------------------------------------------------

# wrap the dataframe in a data frame table so we can use dplyr
data_all <- tbl_df(data_all)

# check whether there are any missing values in the data
# taken from lecture notes, week 3, summarizingData, slide 11
all(colSums(is.na(data_all))==0) # returns [1] TRUE

# -------------------------------------------------

# STEP 2

# subset the data frame leaving only the columns for mean
# and standard deviation (they have 'mean' or 'std' in the name)
# use 'select' from the dplyr package and the special function
# 'contains'

data_all <- select(data_all, contains(grep("mean|std", data_all)))

# can't get select(contains(...)) to work as it returns
# Error: found duplicated column name

# the first 561 columns have the same names as features
# use regexp on names()
n <- grep("mean|std|id|activity", names(data_all))
data_all <- data_all[, n]

# at this stage the dataframe is 10299  X  81
# -----------------------------------------------

# STEP 3

# Use descriptive activity names to name the activities 
# in the data set



