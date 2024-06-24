##################################################
# Making a visuallization for genes presence/abs #
##################################################


# read excel file with multiple sheets
library(readxl)
library(tidyverse)
library(ggpubr)

# check the sheets
excel_sheets("data/structure_data.xlsx")


# read gene presnce data
markers <- read_excel("data/structure_data.xlsx", sheet = "markers_numeric")

# subset to keep only species info and not markers info
only_markers <- markers[ 3:nrow(markers), 1:ncol(markers)-1]

# get rid of _ in names
only_markers <- only_markers %>% separate(col = Species,  sep = "_", into = c("gen", "sp")) %>% unite("Species", c(gen, sp), sep = " ")


# transform into long format
only_markers_long <- pivot_longer( only_markers, cols= rps12:chlL, names_to = "marker", values_to = "value")

# heatmap
order <- colnames(only_markers)[2:ncol(only_markers)]

# species order
sp_order <- c("Calasterella californica", "Asterella cruciata", "Asterella leptophyla",
              "Asterella mussuriensis", "Asterella wallichiana", "Asterellopsis grollei",
              "Cryptomitrium himalayense", "Mannia controversa", "Mannia fragans",
              "Plagiochasma appendiculatum", "Plagiochasma intermedium", "Reboulia hemisphaerica",
              "Riccia cavernosa", "Conocephalum conicum", "Sphaerocarpos texanus", "Blasia pusilla",
              "Haplomitrium mnioides", "Treubia lacunosa", "Fossombronia cristula", "Pellia endiviifolia" ,
              "Makinoa crispata", "Aneura pinguis", "Aneura mirabilis", "Riccardia latifrons", "Metzgeria leptoneura",
              "Cololejeunea lanciloba", "Ptychanthus striatus", "Jubula hutchinsiae", "Frullania nodulosa",
              "Radula japonica", "Ptilidium ciliare", "Bazzania praerupta", "Hebertus dicranus", "Plagiochila chinensis",
              "Trichocolea tomentella", "Calypogeia fissa", "Scapania ciliata", "Schistochilia macrodonta",
              "Cheilolejeunea xanthocarpa", "Sphagnum palustre" )

p <- ggplot( only_markers_long, aes(y = Species, x = marker, fill = value) ) +
          geom_tile(color = "grey") + theme_bw() +
  theme(axis.text.x = element_text(size=9, angle=90,hjust=0.95,vjust=0.2, face = "italic", family = "sans"),
        axis.text.y = element_text(size = 9, face = "italic", family = "sans"),
        legend.position = "none", legend.title = element_blank()) +
  scale_x_discrete(limits = order) + ylab(element_blank()) +
  scale_y_discrete(limits = sp_order) + xlab(element_blank()) +
  scale_fill_manual(values = c( "0" = "white",
                               "1" = "#2c738e",
                               "2" = "#21a585",
                               "3" = "#31b57b",
                               "4" = "#3fbc73",
                               "5" = "#63cb5f",
                               "6" = "#8bd646",
                               "7" = "#a2da37",
                               "9" = "bisque2"))
p


# markers info
markers_region <- markers[ 2, 1:ncol(markers)-1]

markers_region <- pivot_longer(markers_region, cols= rps12:chlL, names_to = "marker", values_to = "region" )

region_plot <- ggplot( markers_region, aes(y = Species, x = marker, fill = region) ) +
  geom_tile() + theme_minimal() +
  scale_x_discrete(limits = order)+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "none", legend.title = element_blank())  +
  ylab(element_blank()) +
  xlab(element_blank()) +
  scale_fill_manual(values = c( "LSC" = "#842681",
                                "SSC" = "#a62d60",
                                "IR" = "#77d153"))

region_plot

# type info
type_info <- markers[ 1, 1:ncol(markers)-1]
type_info <- pivot_longer(type_info, cols= rps12:chlL, names_to = "marker", values_to = "type" )


type_plot <- ggplot( type_info, aes(y = Species, x = marker, fill = type) ) +
  geom_tile() + theme_minimal() +
  scale_x_discrete(limits = order)+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        legend.position = "left",
        legend.title = element_blank())  +
  ylab(element_blank()) +
  xlab(element_blank()) +
  scale_fill_manual(values = c( "PCR" = "#f6d543",
                                "tRNA" = "#21a585",
                                "rRNA" = "#f56b5c"))

type_plot

# put them together
ggarrange(p, region_plot, type_plot,  nrow = 3 , heights = c(12,1,1), align = "v",
           legend = "none") + theme(legend.title=element_blank())




