#Task 5: Day 5 Examples


library(tidyverse)

#Example 1:

money <- c("4,554,25", "$45", "8025.33cents", "288f45")
parse_number(money)

#Example 2:

my_string <- c("123", ".", "3a", "5.4")
parse_integer(my_string, na = ".")

#Example 3:

challenge <-  read_csv(readr_example("challenge.csv"))
problems(challenge)
head(challenge)
tail(challenge)
challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)

#Example 5

download.file("https://educationdata.urban.org/csv/ipeds/colleges_ipeds_completers.csv",
              "colleges_ipeds_completers.csv")

ipeds <- read_csv("colleges_ipeds_completers.csv")
ipeds_2011 <- ipeds %>%
  filter(year == 2011)

write_csv(ipeds_2011, "colleges_ipeds_completers_2011.csv")

#Example #6

install.packages("readxl")
library(readxl)

download.file("https://www.hud.gov/sites/dfiles/Housing/documents/FHA_SFSnapshot_Apr2019.xlsx",
              "sfsnap.xlsx")
excel_sheets("sfsnap.xlsx")
purchases <- read_excel("sfsnap.xlsx", sheet = "Purchase Data April 2019")

