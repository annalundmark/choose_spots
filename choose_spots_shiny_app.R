library(shiny)
library(plotly)

ui <- fluidPage(
  titlePanel("Spatial spot visualization"), 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("D2", "E2"))
    ),
  mainPanel(
    plotlyOutput("plot", height = 680, width = 640),
    verbatimTextOutput("event"), 
    tableOutput("dataTable")
  )
)
)

server <- function(input, output) {
  
  outfile_D2 <- "https://github.com/annalundmark/choose_spots/blob/master/D2_tissue.jpg?raw=true" #without spots
  outfile_E2 <- "https://github.com/annalundmark/choose_spots/blob/master/E2_tissue.jpg?raw=true"
  
  ymin <- 2
  ymax <- 34
  xmin <- 2
  xmax <- 32
  
  x <- c(rep(xmin:xmax, ymax - 1))
  y <- rep(ymin:ymax, each = xmax - 1)
  
  output$plot <- renderPlotly({
    
    if (input$dataset == "D2") {
      outfile <- outfile_D2
      xpos <- -3.8
      ypos <- 2.25
      sizex <- 37.7
      sizey <- 25.75
    } else {
      outfile <- outfile_E2
      xpos <- -4.5
      ypos <- 8.75
      sizex <- 39.5
      sizey <- 26.5
    }
  
    plot_ly(x = x, y = y, type = 'scatter', mode = 'markers', marker =  list(color = "red", opacity = 0.3)) %>%
      layout(
        yaxis = list(autorange = "reversed"), 
        images = list(
          list(
            source =  outfile,
            xref = "x",
            yref = "y",
            x = xpos,
            y = ypos,
            sizex = sizex,
            sizey = sizey,
            sizing = "stretch",
            opacity = 0.8,
            layer = "below"
          )
        )
      )
    
  })
  
  output$event <- renderPrint({
    d <- event_data("plotly_click")
    if (is.null(d)) "Click on a spot to get the coordinates" else d
  })
}

shinyApp(ui, server)