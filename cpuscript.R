library(tidyverse)
library(patchwork)
library(ggrepel)
library(conflicted)

options(ggrepel.max.overlaps = Inf)

cpu_data <- read.csv("https://raw.githubusercontent.com/prunekaryote/CPU-Data-Analysis-Project/refs/heads/main/cpudata.csv")

year_avgGHz <- aggregate(GHz ~ Year, data = cpu_data, FUN = mean)
year_avgGHz$increase_GHz <- c(NA, diff(year_avgGHz$GHz))

year_avgCore <- aggregate(Cores ~ Year, data = cpu_data, FUN = mean)
year_avgCore$increase_Cores <- c(NA, diff(year_avgCore$Cores))

p1 <- ggplot(cpu_data, aes(Year, GHz)) +
  geom_jitter() +
  geom_text_repel(aes(label = Name)) +
  labs(x = "Year", y = "CPU Speed (GHz)") +
  theme_grey()

p2 <- ggplot(year_avgGHz, aes(Year, increase_GHz)) +
  geom_col() +
  theme_minimal() +
    labs(x = "Year", y = "GHz Increase", 
    title = "CPU Increase Year after Year")

p3 <- ggplot(year_avgCore, aes(Year, increase_Cores)) +
               geom_col() +
               theme_minimal() +
               labs(x = "Year", y = "Core(s) Increase",
                    title = "Core Count Increase per Year")