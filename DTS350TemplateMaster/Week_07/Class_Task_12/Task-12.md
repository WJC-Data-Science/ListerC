---
title: "Task 12"
output: 
  html_document:
    keep_md: TRUE
    code_folding: 'hide'
---

**Chance Lister**
  

```r
library(tidyverse)
```

```
## ── Attaching packages ───────────────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
## ✓ tibble  3.0.3     ✓ dplyr   1.0.2
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.5.0
```

```
## ── Conflicts ──────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(readxl)
library(readr)
library(downloader)
```
# Import

```r
mdata <- tempfile()

mdata
```

```
## [1] "/var/folders/cb/xd6bbr2x6ss1lx1ggm4z7v880000gn/T//RtmpnqXF4y/file1055594c42cd"
```

```r
tempdir()
```

```
## [1] "/var/folders/cb/xd6bbr2x6ss1lx1ggm4z7v880000gn/T//RtmpnqXF4y"
```

```r
download("https://raw.githubusercontent.com/WJC-Data-Science/DTS350/master/messy_data.xlsx",
         mdata, mode = "wb")

m_data <- read_xlsx(mdata)
```

```
## New names:
## * `` -> ...4
## * `` -> ...5
## * `` -> ...7
## * `` -> ...8
## * `` -> ...10
## * ...
```

```r
view(m_data)
```

# Tidy


```r
m_data1 <- subset(m_data, select = -c(3,4,6,7,9,10,12,13,15,16))

m_data2 <- m_data1 %>%
  pivot_longer(c('...5','...8','...11','...14','...17'), names_to = 'Class', values_to = 'Grades')

view(m_data2)


m_df <- na.omit(m_data2)

view(m_df)
```

#Visualization/Data


```r
m_vis <- ggplot(data = m_df) +
  geom_bar(mapping = aes(x = Grades, fill = Grades))

m_vis
```

![](Task-12_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

```r
head(m_df, 20)
```

```
## # A tibble: 20 x 4
##    `Studient ID` `Current Major`        Class Grades
##            <dbl> <chr>                  <chr> <chr> 
##  1             1 Computer Science       ...8  A     
##  2             2 Business Analytics     ...11 B+    
##  3             2 Business Analytics     ...14 A     
##  4             3 Electrical Engineering ...5  A     
##  5             4 Computer Science       ...8  B-    
##  6             4 Computer Science       ...11 A-    
##  7             4 Computer Science       ...14 A     
##  8             4 Computer Science       ...17 B     
##  9             5 Applied Mathematics    ...5  A-    
## 10             5 Applied Mathematics    ...8  A     
## 11             6 Psychology             ...11 A-    
## 12             6 Psychology             ...14 A     
## 13             7 Software Engineering   ...8  B-    
## 14             8 Psychology             ...11 B-    
## 15             9 Biochemistry           ...5  A-    
## 16            10 Computer Science       ...8  C     
## 17            11 Data Science           ...5  B     
## 18            11 Data Science           ...11 B-    
## 19            12 Computer Science       ...5  B-    
## 20            13 Computer Science       ...8  A
```

```r
ggsave(
  filename = "Task12_graph1.png",
  plot = last_plot(),
  width = 15,
  units = c("in"),
  dpi = 300
)
```

```
## Saving 15 x 5 in image
```

This visualization shows the total amount of grades in all the classes overall. The classes seem to be going well for the students as we see most of the grades above a B, there is a concerning amount of students that have an F in the classes.
