library(readxl)
library(readr)
library(ggplot2)
library(dplyr)
# Data Sources

## Data Set 1 Suicides
suicides <- read_csv("Suicides.csv")
View(suicides)
# This data set contains 28,000 entries of individual suicides from every country in the world since 1987.
# The data contains age range, gender, country, sucide oer 100K pop of country, and GDP for each country.

## Data Set 2 Tesla
TSLA <- read_csv("TSLA.csv")
View(TSLA)
#Tesla stock price since 2010, with highs, lows, opens, closing prices, and volume.

## Data Set 3 College Salaries
salaries_college <- read_csv("salaries-by-college-type.csv")
View(salaries_college)
# List of colleges, the types of colleges, starting median salary, and quater percentiles of median salary.

# Read in Process/Coding Secrets

# The read in proccess was interesting in the sense that I got to look at multiple different data sets and analyze/begin to make aussuptions and stories
# I can tell with the data. Some coding secrets I have learned so far is that if you put the csv file in your directory it will provide you the code to upload the file.
# Another secret I have learned so far is that R is much better to code in that an Rmd file.

# Visualizations

## Tesla Stock High since 2010

tesla_stock <- ggplot(data = TSLA) +
  geom_path(mapping = aes(x = Date, y = High)) +
  theme_grey() +
  labs(title = "Tesla Stock High Since 2010")
tesla_stock

## Male Suicides in 1985 by Age Group

usa <- filter(suicides, country == "United States")

usa_1985 <- filter(usa, year == 1985)

usa1985m <- filter(usa_1985, sex == "male")

suc_vis <- ggplot(data = usa1985m) +
  geom_point(mapping = aes(x = age, y = suicides_no)) +
  theme_grey() +
  labs(title = "Male Suicides in 1985 by Age Group")

suc_vis

# Limitations 

# There is definitely limitations on my data, for example my suicide data is very limited as it only goes for 15 years.
# I also wish that my college data had more colleges within it. 

# Follow up Questions
# I would want to maybe find a larger data set if I want to pursue the suicide data, and see if there is other college data types to use.