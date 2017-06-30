library(shiny)
shinyUI(fluidPage(
    titlePanel(title = "Diamond price prediction tool", windowTitle = "Diamond price prediction tool"),
    hr(),
    # fluidRow(column(4, h1("foo foo foo foo foofofo")), column(8, h1("value
    # value value valuevalue"))), 
    
    sidebarLayout(
        sidebarPanel(title = "text",
            h3("Choose the parameters of your diamond below")
            
           
        ),
       
        mainPanel(
            h3("Predicted price of your diamond is")
            
        )
    )
))