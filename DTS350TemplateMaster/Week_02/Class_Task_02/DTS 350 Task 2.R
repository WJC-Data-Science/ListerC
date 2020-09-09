#Chance Lister Task 2

#Chapter 4

1 / 200 * 30

(59 + 73 + 2) / 3

sin(pi / 2)

x <- 3 * 4
x

this_is_a_really_long_name <- 2.5

seq(1, 10)

x <- "hello world"
x

y <- seq(1, 10, length.out = 5)
y

(y <- seq(1, 10, length.out = 5))

#Chapter 1
#used mpg and tidyverse instead of flights. 

library(tidyverse)

glimpse(mpg)

view(mpg)

mpg$model

#Comments about R

#New concepts that I learned in R include how do math within R and create numeric lists. I also learned what glimspe does and how I am able to see part of the data without viewing all of it like when you use "View".

#Iris Visulaization

glimpse(iris)

ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species)) +
  geom_point(size = 7,shape = 'square')

# My driving question would be does the species have a direct correlation to the size of the sepal?

#The visualization above helps answer the question above as you can easily distinguish the different species and sizes of the species, and as a result you are able to tell that the species "virginica" has a larger length and middle of the line width, whereas "setosa" has a larger width and smaller length.

