library(shiny)

shinyUI(fluidPage(
    
    titlePanel(title = "Diamond price prediction tool", windowTitle = "Diamond price prediction tool"),
    hr(),
    sidebarLayout(
        
        sidebarPanel(
            tabsetPanel(
                tabPanel(
                    title = "Manual input",
                    h4(em("Choose the parameters of your diamond below")),
                    hr(),
                    sliderInput("carat", label = "Choose carat", min = 0.2, 
                                max = 20, value = 0.2, step = 0.1),
                    radioButtons("cut", label = "Choose cut",
                                 choices = list("Fair", "Good", "Very Good",
                                                "Premium", "Ideal"), 
                                 selected = "Good", inline = TRUE),
                    selectInput("color", label = "Choose color",
                                choices = list("J (worst)" = "J",
                                               "I","H","G","F","E",
                                               "D (best)" = "D"), 
                                selected = "D"),
                    selectInput("clarity", label = "Choose clarity",
                                choices = list("I1 (worst)" = "I1", "SI1", 
                                               "SI2", "VS1", "VS2", "VVS1",
                                               "VVS2", "IF (best)" = "IF"), 
                                selected = "IF")
                ),
                tabPanel(
                    title = "Random simulation"
                )
            )
        ),
        mainPanel(
            br(),
            h4("Predicted price of your diamond is"),
            p(textOutput("result"))
        )
    )
))