# Description: Gather data from data sources and store as csv
# Data Sources: A directory of JPG files (exif) with date information stored in metadata tags.

library(exifr)

photos_path <- '../photos'

img.extentions <- c('jpg')
pattern.img <- paste('*.', img.extentions, sep='')
files <- list.files(photos_path, full.names=TRUE, pattern=pattern.img, ignore.case=TRUE)

dates <- read_exif(files, tags='CreateDate')
wrtie.csv(dates, file="data/CreateDate.csv")
