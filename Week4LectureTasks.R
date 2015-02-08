getwd()
setwd("C:/Users/Helen/Documents/Files_LSE/CoursesTaken/CourseraDataScienceSpecialisation/3Getting_and_Cleaning_Data/Week4")
if(!file.exists("./data")){dir.create("./data")}

#### Editing Text Variables ####

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))
splitNames <- strsplit(names(cameraData), "\\.")
# this creates a list containing the variable names, with both parts of the split name
# in one list element
splitNames
splitNames[[6]][1]
firstPart <- function(x){x[1]}
sapply(splitNames, firstPart)

fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv")
download.file(fileUrl2,destfile="./data/solutions.csv")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)
names(reviews)
sub("_","",names(reviews), )
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)
grep("Alameda",cameraData$intersection)
table(grepl("Alameda",cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]
grep("Alameda",cameraData$intersection,value=TRUE)
grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))

install.packages("stringr")
library(stringr)
nchar("Helen Addison")
substr("Helen Addison",1,5)
paste("Helen","Addison", sep = "!")
paste0("Helen","Addison")
str_trim("              Helen        ")

#### Working with Dates ####
d1 = date()
d1
class(d1)
d2 = Sys.Date()
d2
class(d2)
format(d2, "%a %b %d")
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z = as.Date(x, "%d%b%Y")
z[1]-z[2]
as.numeric(z[1]-z[2])
weekdays(d2)
months(d2)
julian(d2)

install.packages("lubridate")
library(lubridate)
?Sys.timezone