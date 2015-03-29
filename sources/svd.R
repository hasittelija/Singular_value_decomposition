#setwd("Koodit/R/random/Singular_Value_Decomposition/")
require(ggplot2); require(grid)
source("sources/geomareas_to_dataframe.R"); source("sources/makeplot.R")

# grid size from -size, size
circle_precision <- 100

# create unit circle
circle <- get_circle(circle_precision)

toplot <- create_plot(matrix_values, circle_matrix)