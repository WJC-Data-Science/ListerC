#Chance Lister
#Case Study 3

library(tidyverse)
library(readxl)
library(readr)
library(ggplot2)
library(dplyr)
library(measurements)

#1

Census <- read.csv("CensusAtSchool.csv")

#2

df_inch <- Census %>%
  transmute(inch_height = conv_unit(Height, "cm", "inch" ),
            inch_foot = conv_unit(Foot_Length, "cm", "inch"),
            inch_arm = conv_unit(Arm_Span, "cm", "inch"),
  )

glimpse(df_inch)

#3

df_environment <- Census %>% 
  filter(Importance_reducing_pollution >= 750 || Importance_recycling_rubbish >= 750 ||
           Importance_conserving_water >= 750 || Importance_saving_enery >= 750 ||
           Importance_owning_computer >= 750 || Importance_Internet_access >= 750)

df_environment <- arrange(df_environment, desc(Ageyears))

glimpse(df_environment)

#4

df_extra <- Census %>% 
  select(Country, Region, Gender, Ageyears, Handed, Height, Foot_Length, Arm_Span,
         Languages_spoken, Travel_to_School, Travel_time_to_School, Reaction_time,
         Score_in_memory_game, Favourite_physical_activity)

glimpse(df_extra)

#5

df_numbers <- Census %>% 
  group_by(Country) %>% 
  summarise(num_males = sum(Gender == "M", na.rm = TRUE),
            num_females = sum(Gender == "F",na.rm = TRUE),
            mean(Importance_Internet_access,na.rm = TRUE),
            mean(Importance_reducing_pollution,na.rm = TRUE),
            mean(Importance_recycling_rubbish, na.rm = TRUE),
            mean(Importance_conserving_water, na.rm = TRUE),
            mean(Importance_saving_enery, na.rm = TRUE),
            mean(Importance_owning_computer, na.rm = TRUE))

glimpse(df_numbers)

#6

df_gender <- Census %>% 
  group_by(Country, Gender) %>% 
  summarise(mean(Importance_reducing_pollution, na.rm = TRUE),
            sd(Importance_reducing_pollution, na.rm = TRUE),
            mean(Importance_recycling_rubbish, na.rm = TRUE),
            sd(Importance_recycling_rubbish, na.rm = TRUE),
            mean(Importance_conserving_water, na.rm = TRUE),
            sd(Importance_conserving_water, na.rm = TRUE),
            mean(Importance_saving_enery, na.rm = TRUE),
            sd(Importance_saving_enery, na.rm = TRUE),
            mean(Importance_owning_computer, na.rm = TRUE),
            sd(Importance_owning_computer, na.rm = TRUE),
            mean(Importance_Internet_access, na.rm = TRUE),
            sd(Importance_Internet_access, na.rm = TRUE))

glimpse(df_gender)

#7

df_age_pollution <- Census %>%
  group_by(Ageyears) %>%
  summarise(
    pollution_importance = mean(Importance_reducing_pollution, na.rm = TRUE))
            

glimpse(df_age_pollution)

age_pollution <- ggplot(data = df_age_pollution) +
  geom_path(mapping = aes(x = Ageyears, y = pollution_importance,)) +
  geom_path(data = df_age_pollution, mapping = aes(x = Ageyears, y = pollution_importance,)) +
  theme_light() +
  labs(title = "Importance of Reducing Pollution Over Age")

age_pollution

ggsave(
  filename = "CaseStudy3_graph1.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)

df_age_water <- Census %>%
  group_by(Ageyears) %>%
  summarise(
    water_importance = mean(Importance_conserving_water, na.rm = TRUE))

glimpse(df_age_water)

age_water <- ggplot(data = df_age_water) +
  geom_path(mapping = aes(x = Ageyears, y = water_importance,)) +
  geom_path(data = df_age_water, mapping = aes(x = Ageyears, y = water_importance,)) +
  theme_light() +
  labs(title = "Importance of Conserving Water Over Age")

age_water

ggsave(
  filename = "CaseStudy3_graph2.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)
