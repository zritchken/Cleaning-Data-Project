
## Step 1: Merges training and test sets
        ## Part A: We will add in column names which reflect the measurements' description
        ## and we will import the subject and activity columns to both test and train x-data sets:

subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

names(xtrain) <- features$V2
names(xtest) <- features$V2

xtest <- cbind(activity=ytest$V1,xtest)
xtrain <- cbind(activity=ytrain$V1,xtrain)

xtest <- cbind(subject=subjecttest$V1,xtest)
xtrain <- cbind(subject=subjecttrain$V1,xtrain)

xtest <- cbind(test_or_train="test",xtest)
xtrain <- cbind(test_or_train="train",xtrain)
        ## Part B: We will use the rbind function to merge the xtrain and xtest data tables. 
        ## We have to clean up the column names so that we can use the arrange function to sort.

mergedData <- rbind(xtrain,xtest)

valid_column_names <- make.names(names=names(mergedData), unique=TRUE, allow_ = TRUE)
names(mergedData) <- valid_column_names

mergedData <- arrange(mergedData,subject)
        ## End of Step 1.

## Step 2: We extract just the columns that describe mean OR standard deviation details.
        ## We have to remember to keep the first three columns from Step 1.

MeanStdColumns <- c(grep("ean|std",(names(mergedData))))
newMerged <- mergedData[,MeanStdColumns]
newMerged <- cbind(mergedData[,1:3],newMerged)
        ## End of Step 3. - This narrowed our data set down to 89 columns.

## Step 3: We will replace the values in the "activity" field with the actual descriptions.
        ## First, we will import the activity description txt file and create two vectors, a and b.

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
a <- c(activities$V1)
b <- as.character(activities$V2)

newMerged$activity <- b[match(newMerged$activity,a)]
        ## End of Step 3.

## Step 4: We will make some of the column names a bit more tidy by removing "BodyBody,
        ## multiple "...", and also all instances of "mean" will be lowercase.

names(newMerged) <- gsub("BodyBody","Body",colnames(newMerged))
names(newMerged) <- gsub("\\.+",".",colnames(newMerged))
names(newMerged) <- gsub("Mean","mean",colnames(newMerged))
        ## End of Step 4.

## Step 5: We will create a new table, TidyMeans, which has means for all variables broken 
        ## out for all 30 subjects and 6 activities, meaning 180 total observations.


TidyMeans <- ddply(newMerged,.(subject,activity),numcolwise(mean))


