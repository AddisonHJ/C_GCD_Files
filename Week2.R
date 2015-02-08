getwd()
setwd("C:/Users/Helen/Documents/Files_LSE/CoursesTaken/CourseraDataScienceSpecialisation/3Getting_and_Cleaning_Data/Week2")
if (!file.exists("data")) {
     dir.create("data")
}

# Question1
# Answer: 2013-11-07T13:25:07Z

# Question 2: mySQL

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/ACS.csv")
acs <- read.csv("./data/ACS.csv")

install.packages("sqldf")
library(sqldf)

acs[1:6,"pwgtp1"]
acs[1:6,"AGEP"]

class(acs)
sqldf("select pwgtp1 from acs where AGEP < 50") # this is the answer


# Question 3: equivalent function

unique(acs$AGEP)
sqldf("select distinct AGEP from acs")  # this is the answer

# Question 4: HTML

library(XML)
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
htmlCode <- htmlTreeParse(url, useInternalNodes = T)

x <- "<meta name=\"Distribution\" content=\"Global\" />"
nchar(x)
y <- "<script type=\"text/javascript\">"
nchar(y)
z <- "  })();"
nchar(z)
w <- "     			<ul class=\"sidemenu\">"
nchar(w)

# Answer:45 31 7 25


# Question 5: fwf

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "./data/Q5Data.for")
Q5Data <- read.fwf("./data/Q5Data.for", widths = c(-1, 9, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4), skip = 4)
head(Q5Data)
sum(Q5Data$V4)

#Answer: 32426.7