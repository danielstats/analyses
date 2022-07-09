---
title: "The Fastest Food in Rexburg"
author: "Daniel Bagley"
date: '2022-06-29'
output: 
  html_document:
    code_folding: hide
    theme: paper
    floating_toc: TRUE
    keep_md: TRUE
---


```r
pacman::p_load(mosaic, tidyverse)
rxbrg <- read_csv("data/data6_28.csv")
fast_ova <- aov(converted_sec ~ Location, data = rxbrg)
fast_ova <- aov(converted_sec ~ Location + items, data = rxbrg)
```





```r
ggplot(rxbrg, aes(y = converted_sec, x = items)) + geom_point(aes(color = Location)) + geom_smooth(method = "lm", se = FALSE)
```

![](fastish_files/figure-html/unnamed-chunk-2-1.png)<!-- -->



