library(shiny)

shinyUI(fluidPage(
    titlePanel(title = "Diamond price prediction tool", 
               windowTitle = "Diamond price prediction tool"),
    hr(),
    sidebarLayout(
        sidebarPanel(
            tabsetPanel(
                id = "tabset",
                tabPanel(
                    title = "Manual input",
                    value = "Manual",
                    br(),
                    h4(em("Choose the parameters of your diamond below")),
                    hr(),
                    sliderInput("carat", label = "Choose carat", min = 0.2, 
                                max = 20, value = 2.5, step = 0.1),
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
                    title = "Random simulation",
                    value = "Random",
                    br(),
                    h4(em("If you're feeling lazy, you can play with random
                          simulation :)")),
                    hr(),
                    actionButton("random_gen", "Generate random parameters"),
                    br(),
                    br(),
                    wellPanel(
                        helpText("Parameters used for prediction of price:"),
                        h4(code(htmlOutput("rParams")))
                    )
                )
            )
        ),
        mainPanel(
            br(),
            fluidRow(
                column(1),
                column(
                    4,
                    h4("Predicted price of your diamond is"),
                    h3(textOutput("result"))
                ),
                column(
                    5,
                    wellPanel(
                        style="text-align: center;",
                        h5("And that's an approximate size of your diamond"),
                        imageOutput("diamond_img", height = "100%"),
                        helpText(em("Though I'm not a specialist at all..."))
                    )
                )
            ),
            br(),
            plotOutput("plot"),
            absolutePanel(
                bottom = 20, right = 120, width = 350,
                draggable = TRUE,
                style = "opacity: 0.8",
                wellPanel(
                    p("Below you can customize the axes of the plot"),
                    div(style="display: inline-block;vertical-align:top; width: 100px;",
                        selectInput("x", label = "x axis", 
                                    choices = colnames(diamonds[c(1,5:10)]),
                                    selected = colnames(diamonds)[1])),
                    div(style="display: inline-block;vertical-align:top; width: 100px;",
                        selectInput("y", label = "y axis", 
                                    choices = colnames(diamonds[c(1,5:10)]),
                                    selected = colnames(diamonds)[7])),
                    div(style="display: inline-block;vertical-align:top; width: 100px;",
                        selectInput("z", label = "color", 
                                    choices = colnames(diamonds[c(2:4)]),
                                    selected = colnames(diamonds)[2])
                    ),
                    helpText(em("This panel is draggable"))
                )   
            )
        )
    )
))