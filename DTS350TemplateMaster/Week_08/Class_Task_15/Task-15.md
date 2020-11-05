---
title: "Task 15"
output: 
  html_document:
    keep_md: TRUE
    code_folding: hide
---
**Chance Lister**

```r
library(Lahman)
library(blscrapeR)
library(tidyverse)
```

```
## ── Attaching packages ───────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
## ✓ tibble  3.0.3     ✓ dplyr   1.0.2
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.5.0
```

```
## ── Conflicts ──────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(ggplot2)
```
# Cleaning/Combining Data

```r
colleges <- Lahman::CollegePlaying
schools <- Lahman::Schools
players <- Lahman::People
salaries <- Lahman::Salaries

college <- left_join(CollegePlaying, Master, by = "playerID")

college <- left_join(college, Salaries, by = "playerID")

college <- left_join(college, Schools, by = "schoolID")

view(college)

df_college <- college %>% 
  select(playerID, nameGiven, name_full, schoolID, state, salary, yearID.y)

view(df_college)
```
# Missouri Colleges

```r
df_mis <- df_college %>% 
  filter(state == "MO")

view(df_mis)
```
# Inflation

```r
salaries1985 <- filter(Salaries, yearID == "1985") %>%
  mutate(salary = salary * 2.42)
salaries1986 <- filter(Salaries, yearID == "1986") %>%
  mutate(salary = salary * 2.37)
salaries1987 <- filter(Salaries, yearID == "1987") %>%
  mutate(salary = salary * 2.29)
salaries1988 <- filter(Salaries, yearID == "1988") %>%
  mutate(salary = salary * 2.2)
salaries1989 <- filter(Salaries, yearID == "1989") %>%
  mutate(salary = salary * 2.1)
salaries1990 <- filter(Salaries, yearID == "1990") %>%
  mutate(salary = salary * 1.99)
salaries1991 <- filter(Salaries, yearID == "1991") %>%
  mutate(salary = salary * 1.91)
salaries1992 <- filter(Salaries, yearID == "1992") %>%
  mutate(salary = salary * 1.86)
salaries1993 <- filter(Salaries, yearID == "1993") %>%
  mutate(salary = salary * 1.8)
salaries1994 <- filter(Salaries, yearID == "1994") %>%
  mutate(salary = salary * 1.76)
salaries1995 <- filter(Salaries, yearID == "1995") %>%
  mutate(salary = salary * 1.71)
salaries1996 <- filter(Salaries, yearID == "1996") %>%
  mutate(salary = salary * 1.66)
salaries1997 <- filter(Salaries, yearID == "1997") %>%
  mutate(salary = salary * 1.62)
salaries1998 <- filter(Salaries, yearID == "1998") %>%
  mutate(salary = salary * 1.6)
salaries1999 <- filter(Salaries, yearID == "1999") %>%
  mutate(salary = salary * 1.56)
salaries2000 <- filter(Salaries, yearID == "2000") %>%
  mutate(salary = salary * 1.51)
salaries2001 <- filter(Salaries, yearID == "2001") %>%
  mutate(salary = salary * 1.47)
salaries2002 <- filter(Salaries, yearID == "2002") %>%
  mutate(salary = salary * 1.45)
salaries2003 <- filter(Salaries, yearID == "2003") %>%
  mutate(salary = salary * 1.41)
salaries2004 <- filter(Salaries, yearID == "2004") %>%
  mutate(salary = salary * 1.38)
salaries2005 <- filter(Salaries, yearID == "2005") %>%
  mutate(salary = salary * 1.33)
salaries2006 <- filter(Salaries, yearID == "2006") %>%
  mutate(salary = salary * 1.29)
salaries2007 <- filter(Salaries, yearID == "2007") %>%
  mutate(salary = salary * 1.26)
salaries2008 <- filter(Salaries, yearID == "2008") %>%
  mutate(salary = salary * 1.21)
salaries2009 <- filter(Salaries, yearID == "2009") %>%
  mutate(salary = salary * 1.21)
salaries2010 <- filter(Salaries, yearID == "2010") %>%
  mutate(salary = salary * 1.19)
salaries2011 <- filter(Salaries, yearID == "2011") %>%
  mutate(salary = salary * 1.16)
salaries2012 <- filter(Salaries, yearID == "2012") %>%
  mutate(salary = salary * 1.13)
salaries2013 <- filter(Salaries, yearID == "2013") %>%
  mutate(salary = salary * 1.12)
salaries2014 <- filter(Salaries, yearID == "2014") %>%
  mutate(salary = salary * 1.1)
salaries2015 <- filter(Salaries, yearID == "2015") %>%
  mutate(salary = salary * 1.1)
salaries2016 <- filter(Salaries, yearID == "2016") %>%
  mutate(salary = salary * 1.08)

df_salary <- bind_rows(salaries1985,
                       salaries1986,
                       salaries1987,
                       salaries1988,
                       salaries1989,
                       salaries1990,
                       salaries1991,
                       salaries1992,
                       salaries1993,
                       salaries1994,
                       salaries1995,
                       salaries1996,
                       salaries1997,
                       salaries1998,
                       salaries1999,
                       salaries2000,
                       salaries2001,
                       salaries2002,
                       salaries2003,
                       salaries2004,
                       salaries2005,
                       salaries2006,
                       salaries2007,
                       salaries2008,
                       salaries2009,
                       salaries2010,
                       salaries2011,
                       salaries2012,
                       salaries2013,
                       salaries2014,
                       salaries2015,
                       salaries2016)

view(df_salary)
```
# Missouri/Average 

```r
mis_salary <- df_mis %>% 
  group_by(name_full) %>% 
  summarise(mis_salary = sum(salary, na.rm = TRUE))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
view(mis_salary)

mis_salary <- mis_salary %>% 
  filter(mis_salary > 0)

mean_sal <- df_mis %>% 
  group_by(name_full) %>% 
  summarise(mis_salary = mean(salary, na.rm = TRUE))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
view(mean_sal)
```
# Visualization

```r
ggplot(data = mean_sal) +
  geom_col(mapping = aes(x = reorder(name_full, mis_salary), y = mis_salary, fill = name_full)) +
  theme_dark() +
  labs(x = 'Colleges',
       y = 'Avg Salary',
       title = 'Avg Salary by College')
```

```
## Warning: Removed 9 rows containing missing values (position_stack).
```

![](Task-15_files/figure-html/unnamed-chunk-6-1.png)<!-- -->
# Report

When looking at average salary we see that Maple Woods is the largest as future hall of famer Albert Pujols attended Maple Woods and has/had lots of high level contarts. That being said, Missouri is the fourth highest school with Maple Woods, Missori State, and Jefferson in front of them.