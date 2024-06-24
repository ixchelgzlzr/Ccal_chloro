#################################
# compare rates of evolution among partitions
##############################################

library(RevGadgets)
library(dplyr)
library(ggplot2)
library(tidyr)
library(viridis)
library(ggpubr)


# read the trace
file  <- "phylo_analysis/output_newparamt/with_burnin/combined_1.log"
trace <- readTrace( path = file, burnin = 0.25)




# rename parameters
trace[[1]] <- trace[[1]] %>%
  rename( "Structural (P1)" = "relative_rates[1]",
          "Structural (P2)" = "relative_rates[2]",
          "Structural (P3)" = "relative_rates[3]",
          "Structural (P4)" = "relative_rates[4]",
          "Structural (P5)" = "relative_rates[5]",
          "Introns"            = "relative_rates[6]",
          "rbcL"               = "relative_rates[7]",
          "rps4"               = "relative_rates[8]"
            )



# summarice parameters
summarizeTrace(trace = trace, vars = c("Structural (P1)", "Structural (P2)", "Structural (P3)", "Structural (P4)", "Structural (P5)", "Introns", "rbcL", "rps4"))



#-------------------------
# make some plots
#-------------------------

plotTrace(trace = trace, vars = c("Structural (P1)", "Structural (P2)", "Structural (P3)", "Structural (P4)", "Structural (P5)", "Introns", "rbcL", "rps4"))[[1]]


# violin plot


# need to transform the data to long format
cols_c <- c("Structural (P1)", "Structural (P2)", "Structural (P3)", "Structural (P4)", "Structural (P5)", "Introns", "rbcL", "rps4")
trace_subset_c   <- subset(trace[[1]], select = cols_c)
trace_long <- tidyr::pivot_longer(trace_subset_c,
                                        cols = cols_c,
                                        names_to = "parameter",
                                        values_to = "value")

cols <- c( "#fac228", "#9f2a63", "#bc3754", "#277f8e", "#21918c", "#1fa187", "#2db27d", "#4ac16d" )

ggplot(trace_long, aes(x= parameter, y = value, fill = parameter) ) +
  geom_violin(scale = "width",  size = 0.5) +
  scale_fill_manual(values = cols) +
  theme_bw() +
  theme(legend.position = "none",
        axis.text=element_text(size=12),
        axis.text.x = element_text(angle = 45, vjust = 0.5),
        axis.title=element_text(size=14),
        plot.background = element_rect(colour = "grey", fill=NA, size=0.5)) +
  scale_x_discrete(limits = c( "Structural (P1)", "Structural (P2)", "Structural (P3)", "Structural (P4)", "Structural (P5)", "Introns", "rbcL", "rps4")) +
  stat_summary(fun=median,  size=1, color="black") +
  labs(y = "Evolutionary rates", x = "Partition")

