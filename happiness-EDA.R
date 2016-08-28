library(jlR)
library(googlesheets)
library(dplyr)
library(ggplot2)
library(lubridate)

selfSheet <- gs_title("Happiness monitor (Responses)")
selfData <- gs_read(selfSheet)

selfData$Happiness <- as.numeric(selfData$Happiness)
selfData$distanceRun <- as.numeric(selfData$`Distance run`)
selfData$ranToday <- !is.na(selfData$distanceRun)
selfData$Timestamp <- mdy_hms(selfData$Timestamp)
selfData$Screentime <- selfData$Screentime/60/60

# Happiness over time
  ggplot(selfData, aes(x = Timestamp, y = Happiness)) + geom_point() + geom_smooth()

  
# Screentime
  ggplot(filter(selfData, Screentime != is.na(selfData$Screentime)), aes(x = Timestamp, y = Screentime)) + geom_line() + geom_smooth()
  
ggplot(selfData, aes(x = 1, y = Happiness)) + geom_boxplot()
ggplot(selfData, aes(x = ranToday, y = Happiness, colour = ranToday)) + geom_boxplot()

cor.test(selfData$Happiness, selfData$distanceRun)