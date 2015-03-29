library(shiny)
#library(shinyapp)
source("sources/geomareas_to_dataframe.R")

shinyServer(function(input, output) {
    
    matrix_values <- reactive({
        matrix_numbers <- c(input$matrix_1_1,
                            input$matrix_1_2,
                            input$matrix_2_1,
                            input$matrix_2_2)
        return(matrix_numbers)
    })
    
    shape_values <- reactive({
        keijo <-  input$shape
        if (input$shape == "circle") {
            return(get_circle(100))
        } else if (input$shape == "square") {
            return(get_square(100))
        }
    })

    
    output$distPlot <- renderPlot({
        mat_values <- matrix_values()
        shape_matrix <- shape_values()
        
        toplot <- create_plot(mat_values, shape_matrix)
        
        return(toplot)
        
    })
    
})
