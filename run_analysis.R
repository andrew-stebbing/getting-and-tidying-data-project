# A script to create a tidy, summary set of data from the 
# Human Activity Recognition Using Smartphones Dataset Version 1.0 dataset.

# Step 1
library(dplyr)
library(tidyr)

# Step 2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "dataset.zip", method = "curl")
unzip("dataset.zip")

# Step 3
data_folder <- "./UCI HAR Dataset/"
features <- read.table(paste0(data_folder, "features.txt"), stringsAsFactors = FALSE)
activities <- read.table(paste0(data_folder, "activity_labels.txt"))

# read in files from the test folder
folder <- "test"
test_x <- read.table(paste0(data_folder, folder, "/X_", folder, ".txt" ))
test_y <- read.table(paste0(data_folder, folder, "/y_", folder, ".txt" ))
test_s <- read.table(paste0(data_folder, folder, "/subject_", folder, ".txt" ))

# Assembly test files
names(test_x) <- unlist(features[2]) # Step 4
names(test_y) <- "activity"
names(test_s) <- "subject"

test_all <- cbind(test_s, test_y, test_x)
rm(test_x, test_y, test_s)

# read in files from the train folder
folder <- "train"
train_x <- read.table(paste0(data_folder, folder, "/X_", folder, ".txt" ))
train_y <- read.table(paste0(data_folder, folder, "/y_", folder, ".txt" ))
train_s <- read.table(paste0(data_folder, folder, "/subject_", folder, ".txt" ))

# Assemble test files
names(train_x) <- unlist(features[2]) # Step 4
names(train_y) <- "activity"
names(train_s) <- "subject"

train_all <- cbind(train_s, train_y, train_x)
rm(train_x, train_y, train_s)

# Step 5
data_all <- rbind(train_all, test_all)
rm(train_all, test_all)

# Step 6
data_all <- tbl_df(data_all)

if(all(colSums(is.na(data_all))==0)) message("\nThe data frame has no missing values\n")
# returns [1] TRUE

# STEP 7
n <- grep("mean[^F]|std|id|activity", names(data_all))
data_all <- data_all[, n]

# at this stage the dataframe is 10299  X  68

# STEP 8
act <- activities[match(data_all$activity, activities$V1), 2]
data_all$activity <- act

# **********************************************
# ERASE THESE STEPs BEFORE SUBMITTING
# save(data_all, file = "data_all")
# load("./temp_data/data_all")
# ***********************************************

# dimensions are 10299 X 68

# STEP 9
molten_data <- gather(data_all, sample, reading, -subject, -activity)

# **********************************************
# ERASE THESE STEPs BEFORE SUBMITTING
# save(molten_data, file = "molten_data" )
# load("./temp_data/molten_data" )
# **********************************************

# Step 10
molten_data <- mutate(molten_data,
                       statistic = factor( regexpr("mean", molten_data$sample) < 0,
                                           labels = c("average_mean", "average_standard_deviation")))
# Step 11
summary <- summarise(group_by(molten_data, subject, activity, statistic), average_for_activity = mean(reading, na.rm = TRUE))

# Step 12
summary <- spread(summary, statistic, average_for_activity)
# View(summary)
# Step 13
save(summary, file = "summary.RData")



