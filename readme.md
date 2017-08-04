This is the course project for the Getting and Cleaning Data course on courser. The document describes how the script, run_analysis.R, works:

1. Download the dataset zip into the working directory and unzip the dataset.
2. Load the activity and feature info and extract only the data on mean and std for each measurement.
3. Load both the training and test datasets, keeping only those columns which reflect a mean or standard deviation.
4. Load the activity and subject data for each dataset, and merge those columns with the dataset.
5. Merge the two datasets.
6. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy.txt.

   