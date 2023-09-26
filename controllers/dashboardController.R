library(shiny)
library(dplyr)

source("services/getDataset.R")
source("services/getMode.R")
source("services/buildLineGraph.R")

dashboardController <- function(input, output, session) {
    df <- getDataset()

    updateSelectInput(session, "criptoName", label="Selecione a criptomoeda", 
        choices=names(df), selected="bitcoin"
    )

    observe({
        tempName <- input$criptoName

        updateDateRangeInput(session, "daterange", label="Selecione o intervalo de datas",
            start=min(df[[tempName]]$Date), end=max(df[[tempName]]$Date)
        )
    })

    current_frame <- reactive({
        criptoName <- input$criptoName
        daterange <- input$daterange

        temp <- df[[criptoName]]
        temp$Date <- as.Date(temp$Date, format="%Y-%m-%d")

        subset(temp, Date >= daterange[1], Date <= daterange[2])
    })

    output$currencyInfo <- renderTable({
        temp <- current_frame()
        tempMatrix = matrix(
            c(input$criptoName, getMode(temp$Close), mean(temp$Close), median(temp$Close), sd(temp$Close),
                max(temp$Close), min(temp$Close)),
            ncol=7
        )

        colnames(tempMatrix) <- c("Criptomoeda", "Moda", "Media", "Mediana", "desvio padrão",
            "max", "min")

        tempMatrix
    })

    output$lineGraph <- renderPlot({
        temp <- current_frame()
        buildLineGraph(temp$Date, temp$Close)
    })

    output$hist <- renderPlot({
        temp <- current_frame()
        hist(temp$Close, main="", xlab="Valores em USD", ylab="frequência")
    })

    output$boxplot <- renderPlot({
        temp <- current_frame()
        boxplot(temp$Close, main="", xlab="", ylab="valores em USD")
    })
}
