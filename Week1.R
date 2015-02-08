setwd("C:/Users/Helen/Documents/Files_LSE/CoursesTaken/CourseraDataScienceSpecialisation/3Getting_and_Cleaning_Data/Week1")
file.exists("data")

if (!file.exists("data")) {
     dir.create("data")
}

# Question 1: downloading & reading csv file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/housingIdaho.csv")

dateDownloaded <- date()

HousingIdaho <- read.csv("./data/housingIdaho.csv")
head(HousingIdaho)

#How many properties are worth $1,000,000 or more (read codebook to find right column)
Property24 <- HousingIdaho[which(HousingIdaho[ , "VAL"] == 24), ]
length(Property24$VAL)

#Answer: 53

# Question 2: which of the 'tidy data' principles does FES variable violate?

#Answer: Tidy data has one variable per column

# Question 3: downloading & reading xlsx file

library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="./data/gas.xlsx", mode="wb")
dateDownloaded <- date()

#read rows 18-23 and columns 7-15 and assign the result to variable 'dat'
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./data/gas.xlsx", sheetIndex=1, colIndex=colIndex, 
                 rowIndex=rowIndex)
#What is the value of: 
sum(dat$Zip*dat$Ext,na.rm=T) 

#Answer: 36534720

# Question 4: downloading & reading XML file

library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
# Note that I remove the 's' from https:
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)

#How many restaurants have zipcode 21231
rootNode <- xmlRoot(doc)
zipCodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
zipCodes2 <- zipCodes[zipCodes == 21231]
length(zipCodes2)

# Answer: 127

# Question 5: working with data tables

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/housingIdaho2.csv")
library(data.table)

DT <- fread("./data/housingIdaho2.csv")

# Which of the following functions is the fastest way to calculate the average value
# of the variable 'pwgtp15'?

# 1. Check if the functions for calculating mean work
rowMeans(DT)[DT$SEX==1] # This and the following
rowMeans(DT)[DT$SEX==2] # don't work
DT[,mean(pwgtp15),by=SEX] # works
mean(DT$pwgtp15,by=DT$SEX) #returns just one mean
tapply(DT$pwgtp15,DT$SEX,mean) #works
mean(DT[DT$SEX==1,]$pwgtp15) # returns each mean separately
mean(DT[DT$SEX==2,]$pwgtp15)
sapply(split(DT$pwgtp15,DT$SEX),mean) # works

# 2. replicate the calculation in order to increase time needed, so that 
# there aren't any ties between different methods
race = 100
NextDT <- replicate(race, system.time(DT[,mean(pwgtp15),by=SEX]))
NextDTSum <- sum(NextDT["user.self",])

tapplyDT <- replicate(race, system.time (tapply(DT$pwgtp15,DT$SEX,mean)))
tapplyDTSum <- sum(tapplyDT ["user.self",])

sapplyDT <- replicate(race, system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))
sapplyDTSum <- sum(sapplyDT ["user.self",])

# 3. Compare the total time elapsed. Answer: Sapply is quickest.
NextDTSum
tapplyDTSum
sapplyDTSum
