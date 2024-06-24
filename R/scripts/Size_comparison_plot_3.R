
library(readxl)
library(dplyr)
library(ggrepel)
library(tidyverse)
library(ggdist)
library(ggpubr)
library(grid)
library(ggplot2)

# read excel file with multiple sheets

# check the sheets
excel_sheets("data/structure_data.xlsx")

# read gene presnce data
data <- read_excel("data/structure_data.xlsx", sheet = "size")

data <- data[ 1:(nrow(data)-2), ]

# make everything in kb
data$plastome_genome_size <- data$plastome_genome_size / 1000
data$LSC_length           <- data$LSC_length /100
data$IRA_length           <- data$IRA_length /100
data$SSC_length           <- data$SSC_length /100


# Plastome size plot
plastome_size <-ggplot(data = data, aes(x = rep(1, nrow(data)),  y = plastome_genome_size), group = NA) +
  theme_bw() +
  theme(axis.title.x=element_blank(),
        legend.text = element_text(size=12),
        axis.title.y=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=16),
        plot.title = element_text(size=22, hjust = 0.5),
        legend.title = element_blank()) +
  geom_dots( aes(fill = Color, group = NA, order = Color),
             side = "right",
             color = "black", dotsize = 1) +
  scale_fill_manual(values = c("Other liverworts"       = "#482173",
                               "Other Aytoniaceae" = "#1e9b8a",
                               "C. californica"       = "#86d549") ) +
  ggtitle("Plastome") +  guides(colour = guide_legend(override.aes = list(size=30))) +
  guides(fill = guide_legend(override.aes = list(size=6)))


# LSC size plot
LSC_size <- ggplot(data = data, aes(x = rep(1, nrow(data)),  y = LSC_length), group = NA) +
  theme_bw() +
  theme(axis.title.x=element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size=12),
        axis.title.y=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=16),
        plot.title = element_text(size=22, hjust = 0.5)) +
  geom_dots( aes(fill = Color, group = NA, order = Color),
             side = "right",
             color = "black") +
  scale_fill_manual(values = c("Other liverworts"       = "#482173",
                               "Other Aytoniaceae" = "#1e9b8a",
                               "C. californica"       = "#86d549") ) +
  ggtitle( "LSC") +  guides(colour = guide_legend(override.aes = list(size=30))) +
  guides(fill = guide_legend(override.aes = list(size=6)))



#  SSC size
SSC_size <- ggplot(data = data, aes(x = rep(1, nrow(data)),  y = SSC_length), group = NA) +
  theme_bw() +
  theme(axis.title.x=element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size=12),
        axis.title.y=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=16),
        plot.title = element_text(size=22, hjust = 0.5)) +
  geom_dots( aes(fill = Color, group = NA, order = Color),
             side = "right",
             color = "black",  dotsize = 1) +
  scale_fill_manual(values = c("Other liverworts"       = "#482173",
                               "Other Aytoniaceae" = "#1e9b8a",
                               "C. californica"       = "#86d549") ) +
  ggtitle( "SSC") +  guides(colour = guide_legend(override.aes = list(size=30))) +
  guides(fill = guide_legend(override.aes = list(size=6)))



# IR size plot
IR_size <- ggplot(data = data, aes(x = rep(1, nrow(data)),  y = IRA_length), group = NA) +
  theme_bw() +
  theme(axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.text = element_text(size=12),
        axis.text.x=element_blank(),
        legend.title = element_blank(),
        axis.ticks.x=element_blank(),
        axis.title=element_text(size=16),
        plot.title = element_text(size=22, hjust = 0.5)) +
  geom_dots( aes(fill = Color, group = NA, order = Color),

             side = "right",
             color = "black") +
  scale_fill_manual(values = c("Other liverworts"       = "#482173",
                               "Other Aytoniaceae" = "#1e9b8a",
                               "C. californica"       = "#86d549") ) +
  ggtitle( "IR") +  guides(colour = guide_legend(override.aes = list(size=30))) +
  guides(fill = guide_legend(override.aes = list(size=6)))



# All the plots together
fig <- ggarrange(plastome_size, LSC_size, SSC_size, IR_size, ncol = 4, nrow = 1,
          font.label = list(size = 18, face = "bold"), common.legend = T, legend = "bottom")


annotate_figure(fig, left = textGrob("Kbp", rot = 90, vjust = 1, gp = gpar(cex = 1.3)))

