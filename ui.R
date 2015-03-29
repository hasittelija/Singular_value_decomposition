library(shiny)

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Singular Value Decomposition"),
    
    fluidRow(
        column(2 ,
               textInput("matrix_row2",
                         "First Row:",
                         value = "1, 2"),
               textInput("matrix_row2",
                         "Second Row:",
                         value = "2, 1")
        ),
        
        # Show a plot of the generated distribution
        column(10 ,
               plotOutput("distPlot")
        )
    )
))
