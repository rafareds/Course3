## Reading data ##
feat <- read.table("C:\\Users\\Rafael\\Documents\\Coursera\\UCI HAR Dataset\\features.txt")
act <- read.table("C:\\Users\\Rafael\\Documents\\Coursera\\UCI HAR Dataset\\activity_labels.txt")

test.X <- read.table("C:\\Users\\Rafael\\Documents\\Coursera\\UCI HAR Dataset\\test\\X_test.txt")
dim(test.X)
test.Y <- read.table("C:\\Users\\Rafael\\Documents\\Coursera\\UCI HAR Dataset\\test\\Y_test.txt")
dim(test.Y)
train.X <- read.table("C:\\Users\\Rafael\\Documents\\Coursera\\UCI HAR Dataset\\train\\X_train.txt")
dim(train.X)
train.Y <- read.table("C:\\Users\\Rafael\\Documents\\Coursera\\UCI HAR Dataset\\train\\Y_train.txt")
dim(train.Y)

test.sub <- read.table("C:\\Users\\Rafael\\Documents\\Coursera\\UCI HAR Dataset\\test\\subject_test.txt")
train.sub <- read.table("C:\\Users\\Rafael\\Documents\\Coursera\\UCI HAR Dataset\\train\\subject_train.txt")

## Getting variables that contain mean and sd
n1 <- grep("mean()",feat$V2)
n2 <- grep("std()",feat$V2)
n3 <- grep("meanFreq()",feat$V2)
n4 <- which(n1%in%n3)
n1 <- n1[-n4] # excluding meanFreq() variables

X <- rbind(train.X,test.X) #combining train and test sets
X.mean <- X[,n1] #mean data frame from sets
names(X.mean) <- feat$V2[n1] #changing variables names
X.sd <- X[,n2] #sd data frame from sets
names(X.sd) <- feat$V2[n2] #changing variables names

Y <- rbind(train.Y,test.Y) #combining train and test labels
Y$V2 <- 0
for(i in 1:length(Y$V1)){ #transforming labels number to label name
  if(Y$V1[i] == 1){
    Y$V2[i] <- "WALKING"
  } else if(Y$V1[i] == 2){
    Y$V2[i] <- "WALKING_UPSTAIRS"
  } else if(Y$V1[i] == 3){
    Y$V2[i] <- "WALKING_DOWNSTAIRS"
  } else if(Y$V1[i] == 4){
    Y$V2[i] <- "SITTING"
  } else if(Y$V1[i] == 5){
    Y$V2[i] <- "STANDING"
  } else if(Y$V1[i] == 6){
    Y$V2[i] <- "LAYING"
  }
}
names(Y) <- c("V1","Activity") #changing variables names

sub <- rbind(train.sub, test.sub) #combining train and test volunteers
names(sub) <- c("Volunteer") #changing variable name

data <- data.frame(sub,Y,X.mean,X.sd) #combining data frames
data <- data[,-2] #exluding label number variable

library(data.table) #loading data.table package
data2 <- data.table(data) #transforming data in a data.table object
#getting mean of all variables by volunteer number and activity
data3 <- data2[, lapply(.SD, mean), by = c("Volunteer","Activity")] 

#writing data
write.table(data3,"C:\\Users\\Rafael\\Documents\\Coursera\\resultado.txt", 
            row.names=F)
