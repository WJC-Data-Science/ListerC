#Chance Lister

#Task4

library(tidyverse)
library(ggplot2)
library(dplyr)

#Example 1: Iris Data

ggplot(data = iris, mapping = aes(x=Sepal.Width, y = Sepal.Length)) +
  geom_point()

#Exercise 1: Iris data but in geom_point

ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Width, y = Sepal.Length))

#As far as I can tell there is no difference, and after reading cannot find any reason why this would be an advantage or disadvantage?
#Would like futher explanation.

#Example 2: Points are diamond shaped

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species)) +
  geom_point(shape = 18)

#Exercise 2: Points are plus shaped

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species)) +
  geom_point(shape = 3)

#Exercise 3: Points are shaped by species 
#impact of keeping within the aes is points stay consistent
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point()

#Example 4: Points are shaped by species/picking shapes

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_shape_manual(values = c(3,8,11))

#Exercise 5: Scale of Aesthetic

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_shape_manual(values = c(3,8,11)) +
  scale_x_log10() +
  scale_y_log10()

#Exercise 6: Picking colors

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_shape_manual(values = c(3,8,11)) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("purple", "darkorange", "blue"))

#Example 7 Color Changing

p <- ggplot(data = iris, mapping = aes(x=Sepal.Width, 
                                       y = Sepal.Length, 
                                       color = Species,
                                       shape = Species),
            size = 5) +
  geom_point() +
  scale_color_brewer(palette = "Set1")

print(p)

#Example 8: How to create titles etc.

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_shape_manual(values =  c(1, 5, 7)) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("purple", "darkorange", "blue")) + 
  labs(x = "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       title = "This is where the title goes")

#Exercise 8: Changing legend title/changing color title
#If you change both to the same thing they combine in the same legend

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_shape_manual(values =  c(1, 5, 7)) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("purple", "darkorange", "blue")) + 
  labs(x = "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       title = "This is where the title goes",
       shape = "Spieces of Iris",
       color = "Spieces of Iris")

#Example 9: How to center the title

ggplot(data = iris, mapping = aes(x=Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_shape_manual(values =  c(1, 5, 7)) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c(setosa = "purple", versicolor = "darkorange", virginica = "blue")) +
  labs(x= "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       title = "This is where I would put a title") +
  theme(plot.title = element_text(hjust = .5))

#Example 10: How to change the formatting of the graph

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, color = Species, shape = Species)) +
  geom_point() +
  scale_shape_manual(values =  c(1, 5, 7)) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("purple", "orange", "blue")) +
  labs(x = "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       title = "This is where I would put a title",
       shape = "Species of Iris",
       color = "Species of Iris") +
  theme_bw()

#Exercise 10: Trying new themes

ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, color = Species, shape = Species)) +
  geom_point() +
  scale_shape_manual(values =  c(1, 5, 7)) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("purple", "orange", "blue")) +
  labs(x = "Sepal Width (cm)",
       y = "Sepal Length (cm)",
       title = "This is where I would put a title",
       shape = "Species of Iris",
       color = "Species of Iris") +
  theme_light()

#Example 11: Making Seperate Panels for Data

p <- ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                       y = Sepal.Length, 
                                       color = Species,
                                       shape = Species)) +
  geom_point() +
  scale_shape_manual(values =  c(1, 5, 7)) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("purple", "orange", "blue")) +
  labs(x = "Sepal Length (cm)",
       y = "Sepal Width (cm)",
       title = "This is where I would put a title",
       color = "Species of Iris",
       shape = "Species of Iris") + 
  theme(plot.title = element_text(hjust = .5)) +
  theme_bw() +
  facet_wrap(vars(Species)) 

print(p)

#Exercise 11: Adding mean line to Plot
#In the aes() you would put the color as red or black

averages <- iris %>% group_by(Species) %>% summarise(avglength = mean(Sepal.Length))

p + geom_hline(data = averages, mapping = aes(yintercept = avglength))


