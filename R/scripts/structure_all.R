# Figure for publication

source("scripts/presence-abscence_figure.R")
source("scripts/Introns_figure.R")

# put them together
ggarrange(introns_fig,  p, region_plot, type_plot,  nrow = 4 , heights = c(11, 12,1,1), align = "v",
          legend = "none",
          labels = c("a", "b", "", "")) +
  theme(legend.title=element_blank())


pdf("figures/structure_all.pdf", width = 16, height = 18)

ggarrange(introns_fig,  p, region_plot, type_plot,  nrow = 4 , heights = c(11, 11,1,1), align = "v",
          legend = "none") +
  theme(legend.title=element_blank())

dev.off()
