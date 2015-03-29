library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Singular Value Decomposition"),
    
    fluidRow(
        column(3 ,
               h4("Transformation matrix:"),
               
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
                            choices = c("circle", "square")),
               
               radioButtons("svd_part",
                            "Plot full move, or SVD",
                            choices = c(
                                "Whole Transformation" = 0,
                                "First part of SVD" = 1,
                                "First and Second of SVD" = 2),
                            selected = 0),
               
               p("Blue points are mapped to red points by the linear function defined by the chosen transformation matrix"),
               p("TODO apply singular value decomposition to the transformation matrix and plot all the mappings one by one")
               
        ),
        
        column(9 ,
               plotOutput("distPlot", height = 700)
               
        )
    )
))
