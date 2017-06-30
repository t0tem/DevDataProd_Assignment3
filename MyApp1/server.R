library(shiny)

shinyServer(function(input, output) {
    data <- ggplot2::diamonds
    fit <- lm(price ~ carat + cut + color + clarity, data = data)
    
    pred <- reactive({
        newData <- data.frame(carat = input$carat,
                              cut = input$cut,
                              color = input$color,
                              clarity = input$clarity)
        
        predict(fit, newdata = newData)
    })
    
    output$result <- renderText({pred()})
    
})