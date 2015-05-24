# Merging train and test sets into three variables subject, X and Y

data.created  <- F
features  <- read.table('features.txt')
sets  <- c('test','train')

for(set in sets){
        subject.file.name  <- paste(set,'/subject_',set,'.txt', sep='')
        X.file.name  <- paste(set,'/X_',set,'.txt', sep='')
        Y.file.name  <- paste(set,'/Y_',set,'.txt', sep='')
        data.subject  <- read.table(subject.file.name, col.names=c('subject'))
        data.X  <- read.table(X.file.name, col.names=features$V2)
        data.Y  <- read.table(Y.file.name, col.names=c('num.activity'))
        
        if(data.created){
                subject <- rbind(subject,data.subject)
                X  <- rbind(X,data.X)
                Y  <- rbind(Y,data.Y)
               
        }else{
                subject <- data.subject
                X <- data.X
                Y <- data.Y
                data.created  <- T
        }
}

# Extracting the measurements on the mean and standard deviation for each measurement. 

# First variables has 40 features. Only the 6 first is to be kept 
# because they are means and stds. They is 5 variables of this kind. 
first.200.features.selection  <-  rep(c(rep(T,times=6),rep(F,34)),5)

# Following variables has 13 features. Only the 2 first is to be kept
# because they are means and stds. They is 5 variables of this kind.
following.55.features.selection <- rep(c(rep(T,times=2),rep(F,11)),5)

# Following variables has 79 features. Only the 6 first is to be kept
# because they are means and stds. They is 3 variables of this kind.
following.237.features.selection <- rep(c(rep(T,times=6),rep(F,73)),3)

# Following variables has 13 features. Only the 2 first is to be kept
# because they are means and stds. They is 4 variables of this kind.
following.52.features.selection <- rep(c(rep(T,times=2),rep(F,11)),4)

# Following variables has 7 features. They aren't usual mean or std.
following.7.features.selection  <- rep(F,7)

features.selection  <- c(first.200.features.selection,
                         following.55.features.selection,
                         following.237.features.selection,
                         following.52.features.selection,
                         following.7.features.selection)

X  <- subset(X,select=features.selection)

# Merging subject, X and Y
activity.label <- read.table('activity_labels.txt',col.names=c('num','activity'))
activity  <- merge(Y,activity.label,by.x='num.activity',by.y='num',all=T)
data  <- cbind(subject,activity,X)
data  <- data[,-which(names(data)=='num.activity')]

# Average of each variable for each activity and each subject.
data.aggregate  <- aggregate(. ~ subject + activity, data = data, FUN= "mean" )

# ordering
data.aggregate  <- data.aggregate[order(data.aggregate$subject,data.aggregate$activity),]

# Writting data
write.table(data.aggregate,file='activity.txt', row.name=F)

