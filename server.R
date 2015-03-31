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
        start_value <- substr(input$svd_part, 1, 1)
        end_value <- substr(input$svd_part, 4, 4)
        
        end_matrix <- perform_svd(matrix_values(), end_value)
        start_matrix <- perform_svd(matrix_values(), start_value)
        
        shape_matrix <- shape_values()
            
        toplot <- transform_and_create_plot(start_matrix, end_matrix, diag(2), shape_matrix)
        
        return(toplot)
        
    })
    
})
