library(ggplot2)

buildScatteplot <- function(x, y1, y2) {
     x <- x[1:length(y1)]

     data <- data.frame(
          x = x,
          y1 = y1,
          len1 = y1,
          y2 = y2,
          len2 = y2
     )

     # Criar o scatterplot
     ggplot(data) +
     geom_point(aes(x = x, y = y1, size = len1), color = "blue") +
     geom_point(aes(x = x, y = y2, size = len2), color = "red") +
     labs(title = "Scatterplot das criptos",
          x = "",
          y = "",
          color = "")  +
     scale_size_continuous(range = c(2, 10))
}
