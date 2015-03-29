library(shiny)
library(shinyapps)
library(RCurl)
require(ggplot2); require(grid)

source("sources/svd.R")
source("sources/geomareas_to_dataframe.R")
source("sources/makeplot.R")


shinyServer(function(input, output) {
    
    matrix_values <- reactive({
        matrix_numbers <- c(input$matrix_1_1,
                            input$matrix_1_2,
                            input$matrix_2_1,
                            input$matrix_2_2)
        return(matrix(matrix_numbers, nrow = 2, byrow = T))
    })
    
    shape_values <- reactive({
        keijo <-  input$shape
        if (input$shape == "circle") {
            return(get_circle(200))
        } else if (input$shape == "square") {
            return(get_square(200))
        }
    })

    
    output$distPlot <- renderPlot({
        mat_values <- matrix_values()
        
        shape_matrix <- shape_values()
        
        mat_values <- perform_svd(mat_values, input$svd_part)
        
        toplot <- transform_and_create_plot(mat_values, shape_matrix)
        
        return(toplot)
        
    })
    
})
