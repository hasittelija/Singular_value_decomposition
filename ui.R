library(shiny)

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Singular Value Decomposition"),
    
    fluidRow(
        column(3 ,
               h4("Input matrix:"),
               
               fluidRow(column(6 ,
                               numericInput("matrix_1_1",
                                            "[1,1]",
                                            value = 1.5)),
                        column(6,
                               numericInput("matrix_1_2",
                                            "[1,2]",
                                            value = 2))
               ),
               fluidRow(column(6 ,
                               numericInput("matrix_2_1",
                                            "[2,1]",
                                            value = 1)),
                        column(6,
                               numericInput("matrix_2_2",
                                            "[2,2]",
                                            value = 3))
               ),
               radioButtons("shape",
                            "Circle or Square",
                            choices = c("circle", "square"))

        ),
        
        # Show a plot of the generated distribution
        column(9 ,
               plotOutput("distPlot", height = 700)
               
        )
    )
))
