Course3
===================

## Coursera - Getting and Cleaning Data - Course Project - Read Me

To run the script you'll need data.table package.

First step is reading data sets with read.table function:
* features; 
* activity labels; 
* training set and label; 
* test set and label; 
* subjects training and test.

We need to get the variables with mean an sd from all variables in data sets with grep command. Note that variables that contain meanFreq() are included with grep.
I remmove those meanFreq() variables.

I combined training and test sets (X and Y) with rbind and after this I separated the X data set in 2, one with the mean variables and other with sd variables.

I created a second variable in Y data set that changes acitivity number in acitivity label:
* 1 -> WALKING;
* 2 -> WALKING_UPSTAIRS;
* 3 -> WALKING_DOWNSTAIRS;
* 4 -> SITTING;
* 5 -> STANDING;
* 6 -> LAYING.

I combined the subjects, Y, X mean and X sd data sets in one data set named data and, after this, I remmoved the second column (it was the activity number) and changed the varible names.

I transformed the data in a data.table object with data.table package to calculate the mean of all variables by volunteer and activity.

I export this 3rd data set (data3).

