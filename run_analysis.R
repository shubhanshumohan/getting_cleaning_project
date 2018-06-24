#downloadind dataset
file_url<-"http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
download.file(file_url,destfile = "./project_data.zip")


#reading the training dataset
x_train<-read.table("./Dataset/train/X_train.txt")#this file contains the data observed for training set
y_train<-read.table("./Dataset/train/y_train.txt")#this contains the id for the activity
subject_train<-read.table("./Dataset/train/subject_train.txt")#this contains the id of the subject who underwent the training

#reading the test dataset
#The variable used have similar meaning as of the training set
x_test<-read.table("./Dataset/test/X_test.txt")
y_test<-read.table("./Dataset/test/y_test.txt")
subject_test<-read.table("./Dataset/test/subject_test.txt")
features<-read.table("./Dataset/features.txt")#this contains the column names for the training and testing dataset
activity_labels<-read.table("./Dataset/activity_labels.txt")#the activities in the study

#assigning names to the  training datsets.
colnames(x_train)<-features[,2]#the second column of features contains the column names
colnames(y_train)<-"activity_id"
colnames(subject_train)<-"subject_id"

##assigning names to the test dataset.
colnames(x_test)<-features[,2]
colnames(y_test)<-"activity_id"
colnames(subject_test)<-"subject_id"
colnames(activity_labels)<-c("activity_id","activity_type")

#merging the training and testing datsets.
train_data<-cbind(y_train,subject_train,x_train)
test_data<-cbind(y_test,subject_test,x_test)
full_data<-rbind(train_data,test_data)#this is the merged datset.

#subsetting the columns which represent mean and standard deviation data,along with the
# activity_id and the subject_id
col_names<-colnames(full_data)
ind<-grepl("mean",col_names)|grepl("std",col_names)|grepl("activity_id",col_names)|grepl("subject_id",col_names)
full_mean_std<-full_data[,ind]#subsetting the full_data

#assigning decriptive activity in the full_data
full_data_activity<-merge(full_mean_std,activity_labels,by="activity_id",all.x=TRUE)

##tidy data set with the average of each variable for each activity and each subject
TidySet <- aggregate(. ~subject_id + activity_id, full_data_activity, mean)
write.table(TidySet,"./tidy.txt")









