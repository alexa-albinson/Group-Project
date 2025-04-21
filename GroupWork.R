### Group Project ###
## Tyler Huck, Sam Zani, Alexa Albinson ##

# Clear environment
rm(list = ls())

# Set Working Directory (Sam's directory)
setwd("C:/Users/acer/OneDrive/Documents/DAT 511/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

# Load the data from the 'test' folder
test_x <- read.table("test/X_test.txt")
test_y <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")

# Load the data from the 'train' folder
train_x <- read.table("train/X_train.txt")
train_y <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

# Combine the 'x' datasets (features)
combined_x <- rbind(test_x, train_x)

# Combine the 'y' datasets (activities)
combined_y <- rbind(test_y, train_y)

# Combine the 'subject' datasets (subjects)
combined_subject <- rbind(test_subject, train_subject)

# Merge into one full dataset
Merged_data <- cbind(combined_subject, combined_y, combined_x)

# Load feature names
features <- read.table("features.txt")

# Name columns in Merged_data
colnames(Merged_data) <- c("Subject", "Activity", as.character(features$V2))

# Identify columns with mean() or std() in their names
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features$V2)

# Adjust for the first two columns being subject and activity
selected_columns <- c(1, 2, mean_std_indices + 2)

# Subset the data to keep only subject, activity, and mean/std features
Mean_STD_Data <- Merged_data[, selected_columns]

# Load activity labels
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("ActivityCode", "ActivityName")

# Replace activity numbers with descriptive names
Mean_STD_Data$Activity <- factor(Mean_STD_Data$Activity,
                                 levels = activity_labels$ActivityCode,
                                 labels = activity_labels$ActivityName)

# Clean variable names
column_names <- colnames(Mean_STD_Data)
column_names <- gsub("^t", "Time", column_names)
column_names <- gsub("^f", "Frequency", column_names)
column_names <- gsub("Acc", "Accelerometer", column_names)
column_names <- gsub("Gyro", "Gyroscope", column_names)
column_names <- gsub("Mag", "Magnitude", column_names)
column_names <- gsub("BodyBody", "Body", column_names)
column_names <- gsub("-mean\\(\\)", "Mean", column_names)
column_names <- gsub("-std\\(\\)", "STD", column_names)
column_names <- gsub("-meanFreq\\(\\)", "MeanFrequency", column_names)
column_names <- gsub("\\()", "", column_names)
column_names <- gsub("-", "", column_names)
colnames(Mean_STD_Data) <- column_names

# Create tidy dataset with average of each variable for each subject and activity
Final_Tidy_Data <- aggregate(. ~Subject + Activity, Mean_STD_Data, mean)

# Order the dataset by subject and activity
Final_Tidy_Data <- Final_Tidy_Data[order(Final_Tidy_Data$Subject, Final_Tidy_Data$Activity),]

# Export the final tidy dataset
write.table(Final_Tidy_Data, "tidy_dataset.txt", row.name = FALSE)
