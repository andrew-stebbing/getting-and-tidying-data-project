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

# read in the 2 common files to both sets: features and activities
# features will act as the column headings
# activities will act as a lookup table
data_folder <- "./UCI HAR Dataset/"

features <- read.table(paste0(data_folder, "features.txt"))
activities <- read.table(paste0(data_folder, "activity_labels.txt"))

# read in files from the test folder
folder <- "test"

test_x <- read.table(paste0(data_folder, folder, "/X_", folder, ".txt" ))
test_y <- read.table(paste0(data_folder, folder, "/y_", folder, ".txt" ))
test_s <- read.table(paste0(data_folder, folder, "/y_", folder, ".txt" ))

# Assembly
# add column names to the X file
names(test_x) <- unlist(features[2])
# bind on the subjects
names(test_s) <- "id"
test_x_s <- cbind(test_x, test_s)

# remove the old files to free up some memory
rm(test_x, test_s)

# bind on the activities
test_x_all <- 








