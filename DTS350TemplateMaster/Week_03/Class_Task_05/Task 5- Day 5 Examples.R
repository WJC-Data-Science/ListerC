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

#Example 4:

download.file("https://educationdata.urban.org/csv/ipeds/colleges_ipeds_completers.csv",
              "colleges_ipeds_completers.csv")

ipeds <- read_csv("colleges_ipeds_completers.csv")
ipeds_2011 <- ipeds %>%
  filter(year == 2011)

write_csv(ipeds_2011, "colleges_ipeds_completers_2011.csv")

#Example 5:

install.packages("readxl")
library(readxl)

download.file("https://www.hud.gov/sites/dfiles/Housing/documents/FHA_SFSnapshot_Apr2019.xlsx",
              "sfsnap.xlsx")
excel_sheets("sfsnap.xlsx")
purchases <- read_excel("sfsnap.xlsx", sheet = "Purchase Data April 2019")

#ggplot

#Example 6:

p <- ggplot(data = iris, mapping = aes(x=Sepal.Width, 
                                       y = Sepal.Length, 
                                       color = Species,
                                       shape = Species),
            size = 5) +
  geom_point() +
  scale_color_brewer(palette = "Set1") 

install.packages("directlabels")
library(directlabels)

p %>%  direct.label()

p + geom_dl(method = "smart.grid", mapping = aes(label = Species)) + theme(legend.position = "none") 
library(ggrepel)

#Example 7:
#This code uses the mpg data set and groups by class and outputs the best car in terms of MPG per class

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(cty)) == 1)

ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_label(aes(label = model), data = best_in_class, nudge_y = 2, alpha = 0.5) 

ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_label_repel(aes(label = model), data = best_in_class, nudge_x = 1.5, nudge_y = 1)
#ggrepel code made it so the labels are easier to see (lighter background).
#Nudge shifted the labels so that way they were out of the data

ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_text_repel(aes(label = model), data = best_in_class, nudge_x = 1.5, nudge_y = 1)

ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_text_repel(aes(label = model, colour=class), data = best_in_class, nudge_x = 1.5, nudge_y = 1)

  
#Example 8:

p <- ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                       y = Sepal.Length, 
                                       color = Species,
                                       shape = Species),
            size = 5) +
  geom_point() +
  scale_color_brewer(palette = "Set1")

p + theme(
  legend.position = "top",
  panel.grid.major.y = element_blank(), 
  panel.grid.minor.y = element_blank(),
  axis.ticks.length = unit(6, "pt"))

#Example 9:

p +
  labs(title = "Comparing 3 Species of Iris") +
  theme(plot.title = element_text(hjust = .5),
        axis.text.x = element_text(angle = 35))

p +
  labs(title = "Comparing 3 Species of Iris") +
  theme(plot.title = element_text(hjust = 1, size = rel(2)),
        axis.text.x = element_text(angle = 35))
