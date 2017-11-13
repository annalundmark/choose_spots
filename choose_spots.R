library(dplyr)
library(plotly)

outfile <- "http://thecatapi.com/api/images/get.php?api_key=MTAx&id=8bf"
outfile <- "https://github.com/lundmarka/test/blob/master/D2_spots_tissue.jpg?raw=true" #with spots
outfile <- "https://github.com/lundmarka/test/blob/master/D2_tissue.jpg?raw=true" #without spots

ymin <- 2
ymax <- 34
xmin <- 2
xmax <- 32

x <- c(rep(xmin:xmax, ymax - 1))
y <- rep(ymin:ymax, each = xmax - 1)

plot_ly(x = x, y = y, type = 'scatter', mode = 'markers', marker =  list(opacity = 0.3)) %>%
  layout(
    yaxis = list(autorange = "reversed"), 
    images = list(
      list(
        source =  outfile,
        xref = "x",
        yref = "y",
        x = -3.8,
        y = 2.25,
        sizex = 37.7,
        sizey = 25.75,
        sizing = "stretch",
        opacity = 0.8,
        layer = "below"
      )
    )
  )
