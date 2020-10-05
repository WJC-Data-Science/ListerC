---
title: "Case Study 6"
output: 
  html_document:
    keep_md: TRUE
---

**Chance Lister**

library(tidyverse)
library(ggplot2)

view(diamonds)
?diamonds

# Distributions of variables

ggplot(data = diamonds, mapping = aes(x = x)) +
  geom_histogram(fill = "red", color = "black") +
  labs(title = "Length of Diamonds in mm",
    x = "length in mm",
    y = "quantity") +
  theme_grey()

ggplot(data = diamonds, mapping = aes(x = y)) +
  geom_histogram(fill = "red", color = "black") +
  labs(title = "Width of Diamonds in mm",
    x = "width in mm",
    y = "quantity") +
  theme_grey()

ggplot(data = diamonds, mapping = aes(x = z)) +
  geom_histogram(fill = "red", color = "black") +
  labs(title = "Depth of Diamonds in mm",
    x = "depth in mm",
    y = "quantity") +
  theme_grey()

# Distribution of Price

![](CaseStudy6_graph1.png)


price <- ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(fill = 'red', color = 'black') +
  labs(title = "Distribution of Diamond Price",
    y = "quantity") +
  theme_grey()

price

ggsave(
  filename = "CaseStudy6_graph1.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)

Data looks as expected for the most part as we see most diamonds below $5000 and quantity decrease as price increases. It is suprising that around the $4000 mark there is a spike in quantity.

# Most Important Variable

## Length

length <- ggplot(diamonds, aes(x = price, y = x)) +
  geom_point() +
  geom_abline(slope = 1) +
  scale_x_continuous(trans = 'log10') +
  labs(title = "Length and Price",
       y = "Length of diamonds in mm") +
  theme_grey()

length

## Width

width <- ggplot(diamonds, aes(x = price, y = y)) +
  geom_point() +
  geom_abline(slope = 1) +
  scale_x_continuous(trans = 'log10') +
  labs(title = "Width and Price",
       y = "Width of diamonds on mm") +
  theme_grey()
  
width

## Depth

depth <- ggplot(diamonds, aes(x = price, y = z)) +
  geom_point() +
  geom_abline(slope = 1) +
  scale_x_continuous(trans = "log10") +
  labs(title = "Depth and Price",
       y = "Depth of Diamonds in mm") +
  theme_grey()

depth

## Depth and Cut

![](CaseStudy6_graph2.png)

depth_cut <- ggplot(data = diamonds, mapping = aes(x = cut, y = z)) +
  geom_violin(fill = 'Red', color = 'black') +
  labs(title = "Depth and Cut of Diamonds",
    y = "Depth of Diamonds in mm") +
  theme_grey()

depth_cut

ggsave(
  filename = "CaseStudy6_graph2.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)

Most important variable is depth regarding price as price and depth are similar in their rise.
In relation to cut depth is correlated as lower quality diamonds may have a larger depth, meaning that lower quality diamonds may be more expensive simply beacause of their depth.

# Carat by Price

diam <- diamonds %>% 
  mutate(
    type = case_when(
      price < 2500 ~ '<2500',
      price < 5000 ~ '<5000',
      price < 7500 ~ '<7500',
      price < 10000 ~ '<10000',
      price < 12500 ~ '<12500',
      price < 15000 ~ '<15000',
      price < 17500 ~ '<17500',
      price < 20000 ~ '<20000',
      price < 22500 ~ '<22500',
      TRUE ~ '>22500')
  )

str = c("<2500", "<5000", "<7500", "<10000", "<12500", "<15000", "<17500", "<20000", "<22500")

diam$bin1 <- factor(diam$bin1, levels = str)

carat <- ggplot(diam, aes(x = type, y = carat)) +
  geom_violin(fill = 'Red', color = 'black') +
  labs(title = "Carat by Price",
    y = "Depth of Diamonds in mm",
    x = "Carat of Diamond") +
  theme_grey()

carat

# Distribution of large Diamonds versus small Diamonds

![](CaseStudy6_graph3.png)

carat_size <- diamonds %>% 
  select(price, carat) %>% 
  mutate(
    type = case_when(
      carat <= 0.4 ~ "Small",
      carat < 1.04 ~ "Regular",
      carat >= 1.04 ~ "Large"
    )
  ) %>% 
  filter(type != 'Regular')

carat_size_vis <- ggplot(data = carat_size, mapping = aes(x = type, y = price)) +
  geom_violin(fill = 'red', color = "black") +
  labs(title = "Large versus Small Diamonds",
       x = "Size of Diamond") +
  theme_grey()

carat_size_vis

ggsave(
  filename = "CaseStudy6_graph3.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)

Large diamonds have a large distribution of price whereas small diamonds have a fairly even distribution of price. I think it does agree with my expectations as larger diamonds may be rarer or different styles where as smaller diamonds are more than likely similar similar.


# Distribution of Cut, Carat, and Price

![](Graph4.png)

library(lattice)

dist <- cloud(diamonds$price ~ diamonds$cut * diamonds$carat, xlab = "Cut", ylab = "Carat", zlab = "Price")

dist


