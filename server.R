library(shiny)
library(shinyapps)
library(RCurl)
require(ggplot2); require(grid); require(expm)

source("sources/svd.R")
source("sources/geomareas_to_dataframe.R")
source("sources/makeplot.R")

PALETTE <- c("#1b9e77", "#d95f02", "#7570b3", "#e7298a")

shinyServer(function(input, output) {
    trans_matrix <- NULL
    
    matrix_values <- reactive({
        matrix_numbers <- c(input$matrix_1_1,
                            input$matrix_1_2,
                            input$matrix_2_1,
                            input$matrix_2_2)
        base_matrix <- matrix(matrix_numbers, nrow = 2, byrow = T)
        trans_matrix <<- base_matrix %^% input$exponent_by
        return(trans_matrix)
        
    })
    
    shape_values <- reactive({
        keijo <-  input$shape
        if (input$shape == "circle") {
            return(get_circle(200))
        } else if (input$shape == "square") {
            return(get_square(200))
        }
    })

    
    output$trans_matrix <- renderTable({
        matrix_values() # to make this reactive
        return(trans_matrix)
    })
    
    output$distPlot <- renderPlot({
        start_value <- substr(input$svd_part, 1, 1)
        end_value <- substr(input$svd_part, 4, 4)
        
        end_matrix <- perform_svd(matrix_values(), end_value)
        start_matrix <- perform_svd(matrix_values(), start_value)

        shape_matrix <- shape_values()

        start_col <- PALETTE[as.numeric(start_value) + 1]
        end_col <- PALETTE[as.numeric(end_value) + 1] 

        toplot <- transform_and_create_plot(start_matrix, end_matrix, diag(2), shape_matrix, 
                                            startcolor = start_col, endcolor = end_col, size = input$gridSize)
        
        return(toplot)
        
    })
    
})
