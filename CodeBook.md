# CodeBook.md

## 📊 Data Overview
This dataset comes from the [UCI Human Activity Recognition (HAR) Dataset](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones). It contains accelerometer and gyroscope data collected from Samsung Galaxy S smartphones worn by 30 volunteers while performing daily activities. The purpose of the project is to create a clean, tidy dataset that provides the average of each relevant measurement for each activity and subject.

---

## 🧾 Variable Descriptions

### Primary Identifiers
- **Subject**: Integer [1–30]. Identifies the participant.
- **Activity**: Factor with 6 possible values:  
  - WALKING  
  - WALKING_UPSTAIRS  
  - WALKING_DOWNSTAIRS  
  - SITTING  
  - STANDING  
  - LAYING  

### Measurement Variables (Total: 86)
Each of the remaining columns contains a numeric value representing the **mean** of a specific measurement (originally from accelerometer or gyroscope signals) for a subject-activity pair.

#### Example Variable Names:
- `TimeBodyAccelerometerMeanX`: Mean body acceleration in the X direction
- `FrequencyBodyGyroscopeSTDY`: Standard deviation of frequency-domain gyroscope data in the Y direction
- `TimeBodyAccelerometerJerkMagnitudeSTD`: Standard deviation of jerk signal magnitude from the body accelerometer

#### Naming Conventions:
- `Time` / `Frequency`: Time-domain or frequency-domain signals
- `Body`, `Gravity`: Type of acceleration
- `Accelerometer`, `Gyroscope`: Type of sensor
- `Jerk`: Rate of change of signal
- `Magnitude`: Magnitude of 3D vector
- `Mean`, `STD`: Statistical summary (mean or standard deviation)

---

## 🚫 Missing Data Handling
There were no missing values in the original dataset. No imputation, removal, or replacement of values was required.

---

## 🔧 Data Processing Steps

1. Loaded data from the `train` and `test` folders using `read.table()`.
2. Merged the training and test datasets using `rbind()` and `cbind()`.
3. Used `features.txt` to identify and extract columns with `mean()` or `std()` using `grep()`.
4. Replaced activity numbers with labels from `activity_labels.txt`.
5. Cleaned column names to make them human-readable and descriptive.
6. Used `aggregate()` to compute the average of each variable for each subject-activity pair.
7. Exported the final tidy dataset as `tidy_dataset.txt`.

---

## 💻 Code Instructions

To reproduce this dataset:
1. Download and unzip the UCI HAR Dataset into your working directory.
2. Open and run the provided `GroupWork.R` script in R or RStudio.
3. Ensure your working directory is set correctly at the top of the script.
4. The output file `tidy_dataset.txt` will be saved to the working directory.

To load it back in R:
```r
data <- read.table("tidy_dataset.txt", header = TRUE)

---

**Prepared by**: Tyler Huck, Sam Zani, Alexa Albinson  
**Course**: DAT 511 – Business Analytics  
**Date**: April 2025

