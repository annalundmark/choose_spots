#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

ui <- fluidPage(
  plotlyOutput("plot"),
  verbatimTextOutput("event")
)

server <- function(input, output) {
  
  outfile <- "https://github.com/lundmarka/test/blob/master/D2_tissue.jpg?raw=true" #without spots
  
  ymin <- 2
  ymax <- 34
  xmin <- 2
  xmax <- 32
  
  x <- c(rep(xmin:xmax, ymax - 1))
  y <- rep(ymin:ymax, each = xmax - 1)
  
  # renderPlotly() also understands ggplot2 objects!
  output$plot <- renderPlotly({
    
    
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
    
  })
  
  output$event <- renderPrint({
    d <- event_data("plotly_hover")
    if (is.null(d)) "Hover on a point!" else d
  })
}

shinyApp(ui, server)