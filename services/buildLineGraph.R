library(ggplot2)

buildLineGraph <- function(x_value, y_value) {
    data <- data.frame(x_value, y_value)

    ggplot(data, aes(x=x_value, y=y_value)) + geom_line() + 
        labs(title = "Valores do fechamento do dia", x = "Tempo", y = "Valor em USD")    
}

buildLineGraph2 <- function(x_value, y_value, x2_value, y2_value) {
    data1 <- data.frame(x_value, y_value)
    data2 <- data.frame(x2_value, y2_value)

    ggplot() +
        geom_line(data = data1, aes(x = x_value, y = y_value, color = "cripto1"), size = 1) +
        geom_line(data = data2, aes(x = x2_value, y = y2_value, color = "cripto2"), size = 1) +
        labs(title = "Valores do fechamento do dia", x = "Tempo", y = "Valor em USD")  +
        scale_color_manual(values = c("cripto1" = "blue", "cripto2" = "red"))    
}
