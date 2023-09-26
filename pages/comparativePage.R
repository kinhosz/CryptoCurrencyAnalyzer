buildComparativePage <- function() {
    page <- fluidPage(
        selectInput("criptoNameComparative1", label=h3("Selecione a criptomoeda 1"), 
            choices=list("bitcoin", "chainlink", "litecoin"), selected="bitcoin"
        ),
        selectInput("criptoNameComparative2", label=h3("Selecione a criptomoeda 2"), 
            choices=list("bitcoin", "chainlink", "litecoin"), selected="chainlink"
        ),
        dateRangeInput("daterangecomparative", label=h3("Selecione o intervalo de datas")),
        div(
            style = "border-top: 2px solid #000;",
            hr()
        ),
        h3("Comparação do valor fechado de duas criptomoedas"),
        tableOutput("currencyInfoComparative"),
        plotOutput("lineGraphComparative"),
        plotOutput("meanBarplot"),
        plotOutput("scatteplot")
    )

    return(page)
}