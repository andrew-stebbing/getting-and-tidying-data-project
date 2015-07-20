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

library(dplyr)

# There are 2 sets
sets <- c("test", "train")
# and 3 files in each
files <- c("X", "y", "subject")

data_folder <- "./UCI Har Dataset/"

# obtain the features, which will act as the column headings
features <- read.table(paste0(data_folder, "features.txt"))

# 2 level nested loop to read the 6 required file paths
file_paths <- vector(length = 6)
for (i in seq_along(sets)) {
    # read the 3 files
    for (j in seq_along(files))  {
        file_path <- (paste0(data_folder, sets[i], "/", files[j], "_", sets[i], ".txt"))
        index <- i^2 + j - 1
        file_paths[index] <- file_path
    }
}
file_paths

# sequence along the file_paths in 2 sections of 3 files
# read 3 files
# and column names (features to the X file) 
# then add on (cbind) the y and subject files

# obtain details about the 6 types of activities
activities <- read.table(paste0(data_folder, "activity_labels.txt"))










