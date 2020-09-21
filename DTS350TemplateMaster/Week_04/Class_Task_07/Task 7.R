#Chance Lister Task 7

#What do people do with new data article
#"The first thing I do is fool around abit to try to figure out what the data set looks like"
#I like this quote as often I feel lost when I start coding, and one way I can feel less lost is to start looking at my data and what it means.

#Relationship between dep_delay and origin (airport)

library(tidyverse)
library(ggplot2)
library(dplyr)

#Cleaning Data

df_flights <- nycflights13::flights

glimpse(df_flights)

view(df_flights)

#Newark

EWR_dep_delay <- df_flights %>% 
  filter(origin == "EWR") %>% 
  group_by(carrier) %>% 
  summarise(avg_delay_EWR = mean(dep_delay, na.rm = TRUE)) %>% 
  arrange(avg_delay_EWR)

glimpse(EWR_dep_delay)

#JFK

JFK_dep_delay <- df_flights %>% 
  filter(origin == "JFK") %>% 
  group_by(carrier) %>% 
  summarise(avg_delay_JFK = mean(dep_delay, na.rm = TRUE)) %>% 
  arrange(avg_delay_JFK)

glimpse(JFK_dep_delay)

#LaGuardia

LGA_dep_delay <- df_flights %>% 
  filter(origin == "LGA") %>% 
  group_by(carrier) %>% 
  summarise(avg_delay_LGA = mean(dep_delay, na.rm = TRUE)) %>% 
  arrange(avg_delay_LGA)

glimpse(LGA_dep_delay)

#visualizations

#Newark

EWR_dep_delay_vis <- ggplot(data = EWR_dep_delay) +
  geom_col(mapping = aes(fct_reorder(carrier, avg_delay_EWR),
                         y = avg_delay_EWR, fill = carrier )) +
  labs(title = "Average Delay By Carrier at Newark",
       x = "Carrier",
       y = "Average Delay (Min") +
  theme_grey()

ggsave(
  filename = "Task7_graphEWR.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)

#JFK

JFK_dep_delay_vis <- ggplot(data = JFK_dep_delay) +
  geom_col(mapping = aes(fct_reorder(carrier, avg_delay_JFK),
                         y = avg_delay_JFK, fill = carrier)) +
  labs(title = "Average Delay By Carrier at JFK",
       x = "Carrier",
       y = "Average Delay (Min") +
  theme_grey()

ggsave(
  filename = "Task7_graphJFK.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)

#LaGuardia

LGA_dep_delay_vis <- ggplot(data = LGA_dep_delay) +
  geom_col(mapping = aes(fct_reorder(carrier, avg_delay_LGA),
                         y = avg_delay_LGA, fill = carrier)) +
  labs(title = "Average Delay By Carrier at LaGuardia",
       x = "Carrier",
       y = "Average Delay (Min") +
  theme_grey()

ggsave(
  filename = "Task7_graphLGA.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)


EWR_dep_delay_vis
JFK_dep_delay_vis
LGA_dep_delay_vis

#Summarizing this data we can see that the airport with the worst average delay time is LaGuardia while JFK has the average best delay time.
#When looking ta carriers, there is not a typical trend for which carrier has the smallest delay time, but will comment that visualization could be better when comparing carriers.


