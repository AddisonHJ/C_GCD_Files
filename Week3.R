getwd()
setwd("C:/Users/Helen/Documents/Files_LSE/CoursesTaken/CourseraDataScienceSpecialisation/3Getting_and_Cleaning_Data/Week3")
if (!file.exists("data")) {
     dir.create("data")
}
## Question 1: subset households on greater than 10 acres who sold more than
# $10,000 worth of ag products.

# download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/housingIdaho.csv")
dateDownloaded <- date()
dateDownloaded

# read the csv file into R
HousingIdaho <- read.csv("./data/housingIdaho.csv")

# create logical vector that identifies households that meet the 2 conditions
head(HousingIdaho)

AgSelect <- HousingIdaho[which(HousingIdaho$ACR == 3 & HousingIdaho$AGS == 6), ]
head(AgSelect)

# See that the first 3 values that result are: 125, 238, 262

## Question 2: JPEG file

install.packages("jpeg")
library(jpeg)
photoUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(photoUrl, destfile = "./data/PhotoJeff.jpg", mode = "wb")
PhotoJeff <- readJPEG("./data/PhotoJeff.jpg", native = TRUE)

quantile(PhotoJeff, probs = c(0.3, 0.8))

# See that the 30th and 80th quantiles are -15259150 -10575416 respectively

## Question 3: Matching data sets based on country shortcode

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/GDP.csv")
GDP <- read.csv("./data/GDP.csv", skip = 5, nrows = 190, header = FALSE)
GDP <- GDP[ , c(1,2,4,5)]
colnames(GDP) <- c("CountryCode", "Rank", "LongName", "GDP")
head(GDP)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./data/Educ.csv")
Educ <- read.csv("./data/Educ.csv")
head(Educ)

# merge using base R function. mergedData
mergedData <- merge(GDP, Educ, by = "CountryCode", all = FALSE)
head(mergedData)

# merge using plyr function. mergedData2
library(plyr)
mergedData2 <- join(GDP,Educ)
head(mergedData2)

mergedData <- arrange(mergedData, desc(Rank))
mergedData2 <- arrange(mergedData2, desc(Rank))

# See that the merge() command shows 189 matched IDs and the plyer join() command shows
# 190 matched IDs. Both show St. Kitts and Nevis in 13th place. I answered 189 and the quiz 
# scored this as correct.

## Question 4: Average GDP ranking for income groups.
install.packages("dplyr")
library(dplyr)
IncomeGroup <- group_by(mergedData2, Income.Group)
summarize(IncomeGroup, Rank = mean(Rank, na.rm = TRUE))

# See that mean rank for "High income: OECD" is 32.96667 and for "High income: nonOECD"
# is 91.91304

## Question 5: GDP Quantiles

mergedData2$RankQuantile <- cut(mergedData2$Rank, breaks = 5)
table(mergedData2$RankQuantile, mergedData2$Income.Group)

# See that the number of countries in the Rank quartile [0.811, 38.8]
# and in income group 'Lower middle income' is 5 