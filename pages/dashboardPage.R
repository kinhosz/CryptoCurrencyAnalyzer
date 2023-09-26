buildDashbordPage <- function() {
    page <- fluidPage(
        selectInput("criptoName", label=h3("Selecione a criptomoeda"), 
            choices=list("bitcoin", "chainlink", "litecoin"), selected="bitcoin"
        ),
        dateRangeInput("daterange", label=h3("Selecione o intervalo de datas")),
        div(
            style = "border-top: 2px solid #000;",
            hr()
        ),
        h3("Informações sobre o valor de fechamento da criptomoeda"),
        tableOutput("currencyInfo"),
        plotOutput("lineGraph"),
        plotOutput("hist"),
        plotOutput("boxplot")
    )

    return(page)
}