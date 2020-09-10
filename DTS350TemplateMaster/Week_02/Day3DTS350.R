# Day 3:  DPLYR

library(nycflights13) # for data frame
library(tidyverse) # for ggplot2
library(dplyr) # for getting data frame the way we want it

# Our data frame will be flights
?flights
str(flights)
# Question:  How many observations are in this data frame?
# Question:  How many variables are in this data frame?


# The dplyr functions we will learn about:  filter(), arrange(), select(), mutate(), and summarise()

# These will often include the group_by() function and the pipe %>%.

## Filter(data frame, exp1, exp2, ...) 


# Example:  Find all the flights on January 1st.
filter(flights, month == 1, day == 1) #makes a table

filter(flights, dest == "IAH") #makes a table

# Example:  Name the new data frame created in the previous example jan1.
jan1 <- filter(flights, month == 1, day == 1) #makes a table and saves it as something



# Practice:  Create a data frame called dec25 which gives all the flights on Christmas day.  Write the code to immediately display the results.
(dec25 <- filter(flights, month == 12, day == 25)) #make/saves table and shows data

# Comparisons:  >, >=, <, <=, !=, ==

# Try the following:
sqrt(2)^2 == 2 #wrong as one side is float and one side is interger

1 / 49 * 49 == 1 #same as above

near(sqrt(2) ^ 2, 2) #how to do above and get true

near(1 / 49 * 49, 1) #same as above

# Logical Operators:  &, |, !

# Example:  Find all the flight information for any flight in October or December.
filter(flights, month == 10 | month == 12) #straight line is "or"

# What is going on with this code?
filter(flights, month == (10 | 12)) #inccorect as it is looking for when month is 1
filter(flights, month %in% c(10,12)) #correct way to create a list

OctDec = c(10,12)
filter(flights, month %in% OctDec) #another way to create a list

## Arrange(data frame, exp1, exp2, ...) This is like sort in Excel

# Example:  Create a data frame with all of the data from flights, but with the data sorted first by year, then month, then day.
arrange(flights, year, month, day) #how to arrange data a certain way

# Example:  Sort the data in flights by descreasing order in dep_delay.
arrange(flights, desc(month), day) #descending by the month and day


## Select(data frame, exp1, exp2, ...) pulls off specific columns

# Example:  Create a new data frame with only the variables year, month, and day.
select(flights, year, month, day) #how to select what data you want to show
select(flights, year:day) #shortcut 

# Helper functions with select():
  # starts_with("abc")
  # ends_with("xyz")
  # contains("ijk")
  # everything() for rearranging columns

# Example:  Re-arrange the columns in flights so the first two columns are time_hour, air_time, and the rest of the variables follow the same ordering as the original data set.
select(flights, time_hour, air_time, everything()) #how to re-arrange collums, everything is everything else


## Mutate(data frame, newCol1, newCol2, ...)

# Example:  Make a new data frame called flights_sml which has year, month, day, anything with "delay" at the end, distance, and air_time.  Add two columns to flights:  gain = dep_delay - arr_delay and speed = distance / air_time * 60

flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)

mutate(flights_sml,
       gain= dep_delay - arr_delay,
       speed = distance / air_time * 60) #how to edit/add to data

head(flights_sml) #shows data


# If you only want new variables, use transmute()

transmute(flights,
          gain = dep_delay - air_time,
          speed = distance / ait_time * 60)
## Summarise(data frame, expression)

# Example:  Get the average departure delay for all of the data in flights.
summarise(flights, mean(dep_delay, na.rm = TRUE)) #removes the null values in data/ gets avg


# Example:  Find the average departure delay time for each day.
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

## The pipe %>% #progressive steps at once

# Example:  For each destination which is not HNL, find the number of flights to that destination, the average distance for the flights to that destination, and the average arrival delay for that destination. Only display results that have at least 20 flights to the destination.
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
          count = n(),
          avg_flght = mean(distance, na.rm = TRUE),
          avg_delay = mean(arr_delay, na.rm = TRUE))
final_frame <- filter(delay, count > 20, dest != "HNL")
view(final_frame)

delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n( ),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)) %>%
  filter(count > 20, dest != "HNL")

ggplot(data = delays, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

