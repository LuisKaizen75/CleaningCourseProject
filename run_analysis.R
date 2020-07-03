##Get the file
url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"projectdata.zip")
unzip("projectdata.zip")

#Create the test DF

testdata<-read.table("./UCI HAR Dataset/test/subject_test.txt")
testdata<-cbind(testdata,read.table("./UCI HAR Dataset/test/y_test.txt"))
testdata<-cbind(testdata,read.table("./UCI HAR Dataset/test/X_test.txt"))
features<-read.table("./UCI HAR Dataset/features.txt")
names(testdata)<-c("subject","activity",features[,2])

##Create the train DF

traindata<-read.table("./UCI HAR Dataset/train/subject_train.txt")
traindata<-cbind(traindata,read.table("./UCI HAR Dataset/train/y_train.txt"))
traindata<-cbind(traindata,read.table("./UCI HAR Dataset/train/X_train.txt"))
names(traindata)<-c("subject","activity",features[,2])

## 1. Merges the training and the test sets to create one data set.

fulldata<-rbind(traindata,testdata)
print(fulldata)



## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
names<-as.character(features[,2])
mandsd<-grep("mean\\()|std\\()", names)
mandsd<-mandsd+2L
data2<-fulldata[,c(1,2,mandsd)]
print(data2)

## 3. Uses descriptive activity names to name the activities in the data set
anames<-read.table("./UCI HAR Dataset/activity_labels.txt")
anames<-as.character(anames[,2])
data3<-data2
        for (i in 1:nrow(data2)) {
                act<-data2[i,"activity"]
                data3[i,"activity"]<-anames[act]    
        }
        #data3 is the answer
print(data3)

## 4.Appropriately labels the data set with descriptive variable names.
currnames<-colnames(data3)
currnames<-tolower(currnames)
currnames<-sub("^t","time ",currnames[3:length(currnames)])
currnames<-sub("^f","frequency ",currnames)
currnames<-gsub("-"," ",currnames)
currnames<-gsub("\\()","",currnames)
currnames<-gsub("mag","magnitude",currnames)
names(data3)<-c("subject","activity",currnames)
print(data3)

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(tidyr)
library(dplyr)
data4<-group_by(data3,activity,subject)
newtable<-summarize_all(data4,mean)
newtable<-as.data.frame(newtable)
print(newtable)
write.table(newtable,file = "Step5.txt")