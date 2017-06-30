data <- ggplot2::diamonds
fit <- lm(price ~ carat + cut + color + clarity + depth, data = data)
fit2 <- lm(price ~ carat + cut + color + clarity, data = data)
fit3 <- lm(price ~ carat + cut + color, data = data)

summary(fit3)$adj.r.squared

summary(data$carat)
summary(data$cut)
summary(data$color)
summary(data$clarity)
summary(data$depth)

unclass(data$cut[2]) == "Premium"
data$cut[2] == "Premium"

myDiam <- data.frame(carat = 200,
                     cut = "Premium",
                     color = "D",
                     clarity = "VVS2")
myDiam


input <- list(carat = 200,
              cut = "Premium",
              color = "D",
              clarity = "VVS2")


