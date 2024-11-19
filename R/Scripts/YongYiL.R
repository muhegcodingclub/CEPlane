
library(readr)
library(ggplot2)
library(RColorBrewer)

dat <- read_csv("data/results.csv")

ceplane <- ggplot(data = dat) + 
           aes(IncrementalQALYs, IncrementalCosts) + 
           geom_point(color="aquamarine3", size=3, alpha = 0.8) +
           xlab("Inc. QALYs") + ylab("Inc. Costs") +
           geom_abline(slope = 96000, linetype = "dashed") +
           geom_hline(yintercept = 0) +
           geom_vline(xintercept = 0)

ceplane
