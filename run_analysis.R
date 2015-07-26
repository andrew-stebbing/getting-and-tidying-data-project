# A script to create a tidy, summary set of data from the 
# Human Activity Recognition Using Smartphones Dataset Version 1.0 dataset.

# ****************************************************************************************** 

# Note: this script can only be run as long as the Samsung data is in your working directory

# ******************************************************************************************

# Step 1
library(dplyr)
library(tidyr)

# Step 2
data_folder <- "./UCI HAR Dataset/"
features <- read.table(paste0(data_folder, "features.txt"), stringsAsFactors = FALSE)
activities <- read.table(paste0(data_folder, "activity_labels.txt"))

# read in files from the test folder
folder <- "test"
test_x <- read.table(paste0(data_folder, folder, "/X_", folder, ".txt" ))
test_y <- read.table(paste0(data_folder, folder, "/y_", folder, ".txt" ))
test_s <- read.table(paste0(data_folder, folder, "/subject_", folder, ".txt" ))

# Assemble test files
names(test_x) <- unlist(features[2]) # Step 3
names(test_y) <- "activity"
names(test_s) <- "subject"

test_all <- cbind(test_s, test_y, test_x)
rm(test_x, test_y, test_s)

# read in files from the train folder
folder <- "train"
train_x <- read.table(paste0(data_folder, folder, "/X_", folder, ".txt" ))
train_y <- read.table(paste0(data_folder, folder, "/y_", folder, ".txt" ))
train_s <- read.table(paste0(data_folder, folder, "/subject_", folder, ".txt" ))

# Assemble train files
names(train_x) <- unlist(features[2]) # Step 3
names(train_y) <- "activity"
names(train_s) <- "subject"

train_all <- cbind(train_s, train_y, train_x)
rm(train_x, train_y, train_s)

# Step 4
data_all <- rbind(train_all, test_all)
rm(train_all, test_all)

# Step 5
data_all <- tbl_df(data_all)

# STEP 6
n <- grep("mean[^F]|std|subject|activity", names(data_all))
data_all <- data_all[, n]

# STEP 7
act <- activities[match(data_all$activity, activities$V1), 2]
data_all$activity <- act

# STEPS 8 - 12
data_all %>%
    gather(sample, reading, -subject, -activity) %>%
    mutate(statistic = factor( regexpr("mean", .$sample) < 0, labels = c("average_mean", "average_standard_deviation"))) %>%
    group_by(subject, activity, statistic) %>%
    summarise(average_for_activity = mean(reading, na.rm = TRUE)) %>%
    spread(statistic, average_for_activity) %>%
    write.table(file = "summary.txt", row.names = FALSE)

# **** END OF SCRIPT ****


