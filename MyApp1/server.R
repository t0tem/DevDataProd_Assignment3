library(shiny)
library(dplyr)

shinyServer(function(input, output) {
    data <- ggplot2::diamonds
    fit <- lm(price ~ carat + cut + color + clarity, data = data)
    
    pred <- reactive({
        newData <- data.frame(carat = input$carat,
                              cut = input$cut,
                              color = input$color,
                              clarity = input$clarity)
        
        p <- predict(fit, newdata = newData) %>%
            round(digits = 2) %>% format(big.mark = ",", nsmall = 2)
        
        if( p < 0) {p <- 0}
        
        paste0(p, " USD")
    })
    
    output$result <- renderText({pred()})
    output$tabset <- renderText({input$tabset})
    
})