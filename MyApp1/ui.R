library(shiny)

shinyUI(navbarPage(
    title = "",
    tabPanel(
        "Documentation (how to use the app)",
        fluidPage(
            fluidRow(
                column(
                    10,
                    wellPanel(
                        helpText("This application predicts the price of a diamond, 
                                basing on 4 parameters (carat, cut, color, clarity) 
                                by fitting a linear model to the famous 'Diamonds' dataset."),
                        helpText("In order to get your prediction you can use 'Manual input' tab
                                at the left side of the window and choose the values of 
                                4 parameters of your diamond."),
                        helpText("You can also switch to 'Random simulation' tab and have the parameters
                                randomly filled for you (by pressing the button 'Generate random
                                parameters')."),
                        helpText("The result of predicted price will be dispayed in USD 
                                in the middle of the page."),
                        helpText("In the top right corner you will see an approximate size 
                                of your diamond (basing on the chosen carat). Don't hope 
                                too much, it's really approximate and just for fun :)"),
                        helpText("You can also play with the plot visualizing the global 'Diamonds' dataset.
                                Check out the draggable window letting you choose the axes of the plot!"),
                        helpText(
                            "Now go ahead! ", span("Switch to the App at the top of 
                            the page", style = "color:blue")," and calculate your diamond price!"),
                        helpText(
                            style="text-align: right;",
                            "Any comments and contribution are welcome on", 
                            a("GitHub",
                              href = "https://github.com/t0tem/DevDataProd_Assignment3", 
                              target="_blank")
                        )
                    )
                )
            )
        )
    ),
    tabPanel(
        "The App itself",
        fluidPage(
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
        )
    )
)
)