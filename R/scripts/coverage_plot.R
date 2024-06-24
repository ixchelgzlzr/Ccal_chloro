

library(ggplot2)

# read the coverage data
data <- read.csv("data/Coverage.csv", header = T)


# mean coverage
mean_coverage <- mean(data$Coverage)

# make a coverage plot

ggplot(data, aes(x=Position, y=Coverage) ) +
  # mark Inverted repeats
  geom_rect(data=NULL, aes(xmin=82287,xmax=92424, ymin=-Inf, ymax=Inf), fill="paleturquoise3") +
  geom_rect(data=NULL, aes(xmin=112456,xmax=122592, ymin=-Inf, ymax=Inf), fill="paleturquoise3") +
  # mark the coverage
  geom_point( color="darkorchid2", size=0.5) +
  # add mean coverage value
  geom_hline(yintercept = mean_coverage, color="purple4") +
  theme_light() +
  xlab(element_blank()) +
  ylab("Coverage") +
  annotate("text", x=c(40000, 87000, 102000, 118000), y= 1680,
         label= c("LSC", "IRB", "SSC", "IRA"), color= "gray40")

