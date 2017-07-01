library(shiny)
library(dplyr)
library(ggplot2)

data <- ggplot2::diamonds
fit <- lm(price ~ carat + cut + color + clarity, data = data)

shinyServer(function(input, output) {
    
    # rv <- reactiveValues(data = data.frame())
    # 
    # observeEvent(input$norm, { rv$data <- rnorm(100) })
    # observeEvent(input$unif, { rv$data <- runif(100) })    
    
    
    dataRandom <- eventReactive(input$random_gen, {
        data.frame(carat = round(runif(1, 0.2, 20),2),
                   cut = sample(c("Fair", "Good", "Very Good",
                                  "Premium", "Ideal"), 1),
                   color = sample(c("J","I","H","G","F","E","D"), 1),
                   clarity = sample(c("I1", "SI1", "SI2", "VS1", 
                                      "VS2", "VVS1","IF"), 1)) 
    })
    
    newData <- reactive({
        if(input$tabset == "Manual") {
            data.frame(carat = input$carat,
                       cut = input$cut,
                       color = input$color,
                       clarity = input$clarity)
        } else {
           dataRandom()
        }
    
    })
    
    pred <- reactive({
        p <- predict(fit, newdata = newData()) %>%
            round(digits = 2) %>% format(big.mark = ",", nsmall = 2)
        
        if( p < 0) {p <- 0}
        
        paste0(p, " USD")
    })
    
    output$result <- renderText({pred()})
    output$tabset <- renderText({input$tabset})
    
    #random parameters (to draw on sidebar)
    #credits to 'https://stackoverflow.com/questions/23233497/outputting-multiple-lines-of-text-with-rendertext-in-r-shiny'
    output$rParams <- renderUI({
        str1 <- paste0("carat <- ", dataRandom()$carat)
        str2 <- paste0("cut <- ", dataRandom()$cut)
        str3 <- paste0("color <- ", dataRandom()$color)
        str4 <- paste0("clarity <- ", dataRandom()$clarity)
        HTML(paste(str1, str2, str3, str4, sep = '<br/>'))
    })
    
    output$plot <- renderPlot({
        ggplot(data = data, aes(x = carat, y = price, color = cut)) + geom_point()
    })
    
})