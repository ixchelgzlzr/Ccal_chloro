####################################################
# Making a visuallization for introns presence/abs #
####################################################


# read excel file with multiple sheets
library(readxl)

# check the sheets
excel_sheets("data/structure_data.xlsx")

# read gene presnce data
introns <- read_excel("data/structure_data.xlsx", sheet = "introns",
                      col_types = "text")

# get rid of _ in names
introns <- introns %>% separate(col = Species,  sep = "_", into = c("gen", "sp")) %>% unite("Species", c(gen, sp), sep = " ")

# transform into long format
introns_long <- pivot_longer( introns, cols= 2:31, names_to = "intron", values_to = "value")

# heatmap
#order <- colnames(only_markers)[2:ncol(only_markers)]

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

introns_fig <- ggplot( introns_long, aes(y = Species, x = intron, fill = value) ) +
  geom_tile(color = "grey") + theme_bw() +
  theme(axis.text.x = element_text(size=9, angle=90,hjust=0.95,vjust=0.2, face = "italic", family = "sans"),
        axis.text.y = element_text(size = 9, face = "italic", family = "sans"),
        legend.position = "right", legend.title = element_blank()) +
  ylab(element_blank()) +
  scale_y_discrete(limits = sp_order) + xlab(element_blank()) +
  scale_fill_manual(values = c( "0" = "white",
                                "1" = "#2c738e",
                                "NA"= "grey30"))
introns_fig




