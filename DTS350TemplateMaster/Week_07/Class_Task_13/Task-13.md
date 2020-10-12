---
title: "Task 13"
output: 
  html_document:
    keep_md: TRUE
    code_folding: hide
---

**Chance Lister**


```r
library(readr)
library(haven)
library(readxl)
library(downloader)
library(tidyverse)
```

```
## ── Attaching packages ───────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.2     ✓ dplyr   1.0.2
## ✓ tibble  3.0.3     ✓ stringr 1.4.0
## ✓ tidyr   1.1.2     ✓ forcats 0.5.0
## ✓ purrr   0.3.4
```

```
## ── Conflicts ──────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```
# Reading in Data

```r
df_rds  <- read_rds(url("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS"))
df_dta  <- read_dta("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.dta")
df_cvs  <- read_csv("https://raw.githubusercontent.com/WJC-Data-Science/DTS350/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.csv")
```

```
## Parsed with column specification:
## cols(
##   contest_period = col_character(),
##   variable = col_character(),
##   value = col_double()
## )
```

```r
sav <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.sav", sav, mode = "wb")

df_sav <- read_sav(sav)

xlsx <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.xlsx",xlsx, mode = "wb")

df_xlsx <- read_xlsx(xlsx)
```
# Checking if Equal

```r
all_equal(df_dta, df_sav, convert = TRUE)
```

```
## [1] TRUE
```

```r
all_equal(df_dta, df_xlsx, convert = TRUE)
```

```
## [1] TRUE
```

```r
all_equal(df_dta, df_rds, convert = TRUE)
```

```
## [1] TRUE
```

```r
all_equal(df_rds, df_sav, convert = TRUE)
```

```
## [1] TRUE
```

```r
all_equal(df_rds, df_xlsx, convert = TRUE)
```

```
## [1] TRUE
```

```r
all_equal(df_xlsx, df_sav, convert = TRUE)
```

```
## [1] TRUE
```
# Grouping/Mean

```r
df_dta2 <- df_dta %>% 
  separate(contest_period, into = c("Month_to_Month", "Year_End"), sep = -4)

df_dta3 <- df_dta %>% 
  separate(contest_period, into = c("Month_to_Month", "Year_End"), sep = -4) %>%
  group_by(Year_End, variable) %>%
  summarise( mean = mean(value))
```

```
## `summarise()` regrouping output by 'Year_End' (override with `.groups` argument)
```

```r
view(df_dta2)
```
# Graphic

```r
graphic_1 <- ggplot(data = df_dta2) +
  geom_boxplot(mapping = aes(x = Year_End, y = value)) +
  labs(x = "Year End", 
       y = "Price", 
       color = "Stocks", 
       title = "Preformance of Pro Stock Selections") +
  theme_minimal()

graphic_1
```

![](Task-13_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
graphic_2 <- ggplot(data = df_dta3) +
  geom_line(mapping = aes(x = Year_End, y = mean, color = variable, group = variable)) +
  labs(x = "Year End", 
       y = "Price", 
       color = "Stocks", 
       title = "Mean Price of Stocks") +
  theme_minimal()

graphic_2
```

![](Task-13_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

```r
graphic_3 <- ggplot(data = df_dta2) + 
  geom_jitter(mapping = aes(x = Year_End, y = value, color = variable))+
  labs(x = "Year End",
       y = "Price",
       color = "Stock",
       title = "Prices of Sticks over Years") +
  theme_minimal()

graphic_3
```

![](Task-13_files/figure-html/unnamed-chunk-5-3.png)<!-- -->

```r
graphic_4 <- ggplot(data = df_dta3) +
  geom_line( mapping = aes(group = variable, x = Year_End , y = mean, color  = variable), size = 1.5)+
  geom_jitter( data = df_dta2, mapping = aes(x = Year_End, y = value, color = variable))+
  labs(x = "Year End",
       y = "Price",
       color = "Stock",
       title = "Prices and Mean Prices of Stocks")

graphic_4
```

![](Task-13_files/figure-html/unnamed-chunk-5-4.png)<!-- -->
# Tidying Data

```r
df_tidy <- df_dta2 %>%
  separate(`Month_to_Month`, into = c("month_begin","month_end"), sep = "-")

view(df_tidy)
```
# Saving Tidy Data

```r
saveRDS(df_tidy,"dft_tidy.rds")
```
# Six Month Returns Plots

```r
month_return <- ggplot(data = df_dta2) +
  geom_point(mapping = aes(x = Year_End, y = value, color = variable)) +
  labs(x = "Year End",
       y = "Price",
       color = "Stock",
       title = "Prices and Mean Prices of Stocks") +
  theme_minimal()

month_return
```

![](Task-13_files/figure-html/unnamed-chunk-8-1.png)<!-- -->
# Final Table

```r
df_dta4 <- df_tidy %>%
  mutate(month_end = replace(month_end, month_end == "Dec.", "December")) %>%
  mutate(month_end = replace(month_end, month_end == "Febuary", "February")) %>%
  select(-c(month_begin)) %>%
  filter(variable == "DJIA") %>%
  pivot_wider(names_from = Year_End, values_from = value) %>%
  select(-c(variable)) %>%
  mutate(month_end = replace(month_end, month_end == "January", 1)) %>%
  mutate(month_end = replace(month_end, month_end == "February", 2)) %>%
  mutate(month_end = replace(month_end, month_end == "March", 3)) %>%
  mutate(month_end = replace(month_end, month_end == "April", 4)) %>%
  mutate(month_end = replace(month_end, month_end == "May", 5)) %>%
  mutate(month_end = replace(month_end, month_end == "June", 6)) %>%
  mutate(month_end = replace(month_end, month_end == "July", 7)) %>%
  mutate(month_end = replace(month_end, month_end == "August", 8)) %>%
  mutate(month_end = replace(month_end, month_end == "September", 9)) %>%
  mutate(month_end = replace(month_end, month_end == "October", 10)) %>%
  mutate(month_end = replace(month_end, month_end == "November", 11)) %>%
  mutate(month_end = replace(month_end, month_end == "December", 12)) 

df_dta4$month_end <- as.integer(df_dta4$month_end)

df_dta4 <- df_dta4[order(df_dta4$month_end),]

df_dta4 <- df_dta4 %>%
  mutate(month_end = replace(month_end, month_end == 1,"January")) %>%
  mutate(month_end = replace(month_end, month_end == 2,"February")) %>%
  mutate(month_end = replace(month_end, month_end == 3,"March")) %>%
  mutate(month_end = replace(month_end, month_end == 4,"April")) %>%
  mutate(month_end = replace(month_end, month_end == 5,"May")) %>%
  mutate(month_end = replace(month_end, month_end == 6,"June")) %>%
  mutate(month_end = replace(month_end, month_end == 7,"July")) %>%
  mutate(month_end = replace(month_end, month_end == 8,"August")) %>%
  mutate(month_end = replace(month_end, month_end == 9,"September")) %>%
  mutate(month_end = replace(month_end, month_end == 10,"October")) %>%
  mutate(month_end = replace(month_end, month_end == 11,"November")) %>%
  mutate(month_end = replace(month_end, month_end == 12,"December"))

head(df_dta4, 12)
```

```
## # A tibble: 12 x 10
##    month_end `1990` `1991` `1992` `1993` `1994` `1995` `1996` `1997` `1998`
##    <chr>      <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
##  1 January     NA     -0.8    6.5   -0.8   11.2    1.8   15     19.6   -0.3
##  2 February    NA     11      8.6    2.5    5.5    3.2   15.6   20.1   10.7
##  3 March       NA     15.8    7.2    9      1.6    7.3   18.4    9.6    7.6
##  4 April       NA     16.2   10.6    5.8    0.5   12.8   14.8   15.3   22.5
##  5 May         NA     17.3   17.6    6.7    1.3   19.5    9     13.3   10.6
##  6 June         2.5   17.7    3.6    7.7   -6.2   16     10.2   16.2   15  
##  7 July        11.5    7.6    4.2    3.7   -5.3   19.6    1.3   20.8    7.1
##  8 August      -2.3    4.4   -0.3    7.3    1.5   15.3    0.6    8.3  -13.1
##  9 September   -9.2    3.4   -0.1    5.2    4.4   14      5.8   20.2  -11.8
## 10 October     -8.5    4.4   -5      5.7    6.9    8.2    7.2    3     NA  
## 11 November   -12.8   -3.3   -2.8    4.9   -0.3   13.1   15.1    3.8   NA  
## 12 December    -9.3    6.6    0.2    8      3.6    9.3   15.5   -0.7   NA
```
