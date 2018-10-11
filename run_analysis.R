
## Downloading the Data from Original Source and Unzipping ##
if (!file.exists("C:/Data")){
    dir.create(("C:/Data"))
}
setwd("C:/Data")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "C:/Data/CleanDataProj")
data <- unzip("C:/Data/CleanDataProj")


## Installing and Loading Relevant Packages ##
install.packages("readr")
install.packages("dplyr")
library(readr)
library(dplyr)
library(tidyr)

##STEP1##

## Loading and Renaming Necessary Files to R ##
activity_labels <- read.table(data[[1]])
features <- read.table(data[[2]])

test_subject <- read.table(data[[14]])
test_domain_variables <- read.table(data[[15]])
test_activity_label <- read.table(data[[16]])

train_subject <- read.table(data[[26]])
train_domain_variables <- read.table(data[[27]])
train_activity_label <- read.table(data[[28]])

View(test_domain_variables)
## Combining Test and Training Data Sets ##
CombinedSubject <- rbind(test_subject, train_subject)
CombinedActivityLabel<- rbind(test_activity_label, train_activity_label)
Combined_domain_variables <- rbind(test_domain_variables, train_domain_variables)

##STEP 3##
## Adding Descriptions to Activity labels and Removing Corresponding Activity Code ## 
CombinedActivityLabel$Activity <- apply(CombinedActivityLabel, 1, function(i) {
    if(i == 1){
        CombinedActivityLabel$Activity <- "WALKING"
    }
    else if(i == 2){
        CombinedActivityLabel$Activity <- "WALKING_UPSTAIRS"
    }
    else if(i == 3){
        CombinedActivityLabel$Activity <- "WALKING_DOWNSTAIRS"
    }
    else if(i == 4){
        CombinedActivityLabel$Activity <- "SITTING"
    }
    else if(i == 5){
        CombinedActivityLabel$Activity <- "STANDING"
    }
    else{
        CombinedActivityLabel$Activity <- "LAYING"
    }
})
CombinedActivityLabel$V1 <- NULL


## Renaming Subject Column and Adding Appropriate Feature Names from features.txt Data Set as Column Names ##
colnames(CombinedSubject) <- c("Subject") 
colnames(Combined_domain_variables) <- (features$V2)

##STEP2##

## Filtering Domain Variable Data for Only Measures of Std or Mean ## 
Combined_domain_variables <- Combined_domain_variables[grepl("mean|std", colnames(Combined_domain_variables))]
Combined_domain_variables <- Combined_domain_variables[!grepl("Freq", colnames(Combined_domain_variables))]


## Combinging Subject, Activity, and Domain Variable Data Frames ##
Combined_data_set <- cbind(CombinedSubject, CombinedActivityLabel, Combined_domain_variables)

##STEP 4##
## Cleaning Up Column Names in Combined Data Set ##
names(Combined_data_set) <- gsub("-","",names(Combined_data_set))
names(Combined_data_set) <- gsub("\\(\\)","",names(Combined_data_set))
names(Combined_data_set) <- gsub("^t","time",names(Combined_data_set))
names(Combined_data_set) <- gsub("^f","frequency",names(Combined_data_set))
names(Combined_data_set) <- gsub("BodyBody","Body",names(Combined_data_set))
names(Combined_data_set) <- tolower(names(Combined_data_set))

##STEP 5##
## Creating a Second [tidy] Data Set with the Average of Each Variable for Each Subject and Activity ## 
TidyAvgSubjectFeature <- Combined_data_set %>% gather(feature,average, -subject,-activity) %>% 
    group_by(subject,activity,feature) %>% 
    summarise(average=mean(average)) %>% ungroup()%>%
    arrange(subject, activity)

write.table(TidyAvgSubjectFeature, file = "C:/Data/TidyAvgSubjectFeature.txt", row.names = F)


