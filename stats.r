library(dplyr)
library(lubridate)
library(ggplot2)

dates <- read.csv('data/CreateDate.csv') # returns a data frame
dates <- mutate(dates, datetime=ymd_hms(CreateDate), date=as_date(datetime), time=hms::as.hms(datetime), diff=hms::as.hms(datetime-lag(datetime,1)))

p1 <- ggplot(dates, aes(date)) + geom_histogram(binwidth=2) + ggtitle('Count of photos taken per day') + xlab("") + ylab("")
p2 <- ggplot(dates, aes(time)) + geom_histogram(binwidth=60*60) + ggtitle('Count of photos taken during each hour') + xlab('Time of day')
p3 <- ggplot(dates, aes(diff)) + geom_histogram() + scale_y_log10()
p4 <- dates %>% filter(hms::hms(hours=6) < diff) %>% ggplot(aes(diff)) + geom_histogram() + xlab("Time (H:M:S)")
p5 <- dates %>% filter(diff > hms::hms(seconds=10)) %>% ggplot(aes(date)) + geom_histogram()

f <- function(x) {
  length(
    filter(dates, hms::hms(seconds=x) <= diff )$diff
  )
}

dates <- dates %>% mutate(section=ifelse(date < as_datetime('20170814'), 'PCT', 'OCT'))


