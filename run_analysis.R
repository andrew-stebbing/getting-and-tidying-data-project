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
library(tidyr)

# STEP 1.
# read in the 2 common files to both sets: features and activities
# features will act as the column headings
# activities will act as a lookup table
data_folder <- "./UCI HAR Dataset/"

# features <- read.table(paste0(data_folder, "features.txt"), as.is = c(TRUE, TRUE))
features <- read.table(paste0(data_folder, "features.txt"), stringsAsFactors = FALSE)
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

# doesn't work
# data_all <- select(data_all, contains(grep("mean|std", data_all)))

# can't get select(contains(...)) to work as it returns
# Error: found duplicated column name

# the first 561 columns have the same names as features
# use regexp on names()
n <- grep("mean[^F]|std|id|activity", names(data_all))
data_all <- data_all[, n]

# at this stage the dataframe is 10299  X  68

# -----------------------------------------------

# STEP 3

# Use descriptive activity names to name the activities 
# in the data set
# Use the activities dataframe as a look-up table

act <- activities[match(data_all$activity, activities$V1), 2]
# returns a vector of factors which can be used to convert
# the activities columns
data_all$activity <- act

# **********************************************
# save the file
# EARSE THESE STEP BEFORE SUBMITTING
save(data_all, file = "./temp_data/data_all")
load("./temp_data/data_all")
# ***********************************************

# dimensions are 10299 X 68

# ------------------------------------------------

# STEP 4

# Appropriately label the data set with descriptive variable names.
# Can use the "contains" sub-expression with rename
# substitute column names for either standard deviation or mean


# melt the columns into rows of 1 observation per row (need a name)
molten_data <- gather(data_all, sample, reading, -id, -activity)
# produces a long file of 679734      4 = 10299 * 66

# aggregate by subject > activity > name
# unnecessary
# molten_data <- arrange(molten_data, id, activity, sample)

# **************************************
save(molten_data, file = "./temp_data/molten_data" )
load("./temp_data/molten_data" )

# create a new column of factors "mean", "standard_deviation"
# code from dplyr example
# chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
molten_data <- mutate(molten_data,
                       statistic = factor( regexpr("mean", molten_data$sample) < 0,
                                           labels = c("mean", "standard_deviation")))

# calculate the average for each grouping
summary <- summarise(group_by(molten_data, id, activity, statistic), average_for_activity = mean(reading, na.rm = TRUE))

# spread out the mean and standard deviation variables
summary <- spread(summary, statistic, average_for_activity)

# save the summary file
save(summary, file = "./temp_data/summary_data")
load("./temp_data/summary_data")
