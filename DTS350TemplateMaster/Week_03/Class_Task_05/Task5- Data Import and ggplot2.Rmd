---
title: 'Task 5: Data Import and ggplot2'
output:
  html_document:
    keep_md: true
---
*Chance Lister*

# Explanation

What I learned this task is how to firstly upload outside data and manipulate that data. I also learned how to use the ggrepel library and make my plots look cleaner. What I struggled with specfically was coloring my labels by class and ran into issues rotating my title.

# Inserting Data

library(readxl)

download.file("https://github.com/fivethirtyeight/nba-player-advanced-metrics/raw/master/nba-data-historical.csv", "nba-data-historical.csv")

NBA <- read_csv("nba-data-historical.csv")

NBA_2020 <- NBA %>%
  filter(df$year_id == 2020)
  order(df$MPG)

write_csv(NBA_2020, "nba-data-historical_2020.csv")

Here I took the NBA historical data and filtered to only include 2020, and I then ordered the data by MPG(Minutes Per Game) to see what players in 2020 played the highest amount of minutes per game.
