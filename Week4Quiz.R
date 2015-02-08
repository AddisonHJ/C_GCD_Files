getwd()
setwd("C:/Users/Helen/Documents/Files_LSE/CoursesTaken/CourseraDataScienceSpecialisation/3Getting_and_Cleaning_Data/Week4")
if (!file.exists("data")) {
     dir.create("data")
}
## Question 1: splitting variable names and stripping text

# download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/housingIdaho.csv")

# read the csv file into R
HousingIdaho <- read.csv("./data/housingIdaho.csv")

names(HousingIdaho)
splitNames <- strsplit(names(HousingIdaho), "wgtp")
splitNames[[123]]

# Answer: "" "15"

## Question 2: remove commas and average GDP numbers

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/GDP.csv")
GDPRank <- read.csv("./data/GDP.csv", skip = 5, nrows = 190, header = FALSE)
GDPRank <- GDPRank[ , c(1,2,4,5)]
colnames(GDPRank) <- c("CountryCode", "Rank", "LongName", "GDP")
head(GDPRank)

# Remove commas.
GDPRank2 <- transform(GDPRank, GDP = gsub(",","", GDP))
# The GDP variable is a factor variable. Change it to numeric.
GDPRank2$GDP <- as.numeric(GDPRank2$GDP)
mean(GDPRank2$GDP)

# Answer: 377652.4

## Question 3: Regex and United

length(grep("^United", GDPRank2$LongName))

## Question 4: merged data. Fiscal year in June.

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/GDP.csv")
GDP <- read.csv("./data/GDP.csv", skip = 5, nrows = 190, header = FALSE)
GDP <- GDP[ , c(1,2,4,5)]
colnames(GDP) <- c("CountryCode", "Rank", "LongName", "gdp")
head(GDP)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./data/Educ.csv")
Educ <- read.csv("./data/Educ.csv")
head(Educ)

# merge using base R function. mergedData
mergedData <- merge(GDP, Educ, by = "CountryCode", all = FALSE)

length(grep("Fiscal year end: June", mergedData$Special.Notes))

# Answer: 13

## Question 5: Stock Prices in 2012

install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
class(sampleTimes)  # is a Date vector
sampleTimes2 <- as.character(sampleTimes)
length(grep("2012", sampleTimes2))

# Answer: 250 values collected in 2012

Only2012 <- grepl("2012", sampleTimes2)
sampleTimesOnly2012<- sampleTimes2[Only2012]
class(sampleTimesOnly2012)
sampleTimesOnly2012b <- as.Date(sampleTimesOnly2012)
class(sampleTimesOnly2012b)

Weekday <- weekdays(sampleTimesOnly2012b)
length(grep("Monday", Weekday))

# Answer: 47 Mondays in 2012
