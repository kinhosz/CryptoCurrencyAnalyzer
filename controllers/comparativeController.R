library(shiny)
library(dplyr)

source("services/getDataset.R")
source("services/getMode.R")
source("services/buildLineGraph.R")
source("services/buildScatteplot.R")

comparativeController <- function(input, output, session) {
    df <- getDataset()

    updateSelectInput(session, "criptoNameComparative1", label="Selecione a criptomoeda comparativa", 
        choices=names(df), selected="bitcoin"
    )

    updateSelectInput(session, "criptoNameComparative2", label="Selecione a criptomoeda comparativa", 
        choices=names(df), selected="chainlink"
    )

    observe({
        tempName1 <- input$criptoNameComparative1
        tempName2 <- input$criptoNameComparative2

        updateDateRangeInput(session, "daterangecomparative", label="Selecione o intervalo de datas",
            start=max(min(df[[tempName1]]$Date), min(df[[tempName2]]$Date)), end=min(max(df[[tempName1]]$Date), max(df[[tempName2]]$Date))
        )
    })

    current_frame_comparative_1 <- reactive({
        criptoName <- input$criptoNameComparative1
        daterange <- input$daterangecomparative

        temp <- df[[criptoName]]
        temp$Date <- as.Date(temp$Date, format="%Y-%m-%d")

        subset(temp, Date >= daterange[1], Date <= daterange[2])
    })

    current_frame_comparative_2 <- reactive({
        criptoName <- input$criptoNameComparative2
        daterange <- input$daterangecomparative

        temp <- df[[criptoName]]
        temp$Date <- as.Date(temp$Date, format="%Y-%m-%d")

        subset(temp, Date >= daterange[1], Date <= daterange[2])
    })

    output$currencyInfoComparative <- renderTable({
        temp1 <- current_frame_comparative_1()
        temp2 <- current_frame_comparative_2()
        tempMatrix = matrix(
            ncol=7,
            nrow=2
        )

        tempMatrix[1, ] <- c(input$criptoNameComparative1, getMode(temp1$Close), mean(temp1$Close), 
            median(temp1$Close), sd(temp1$Close), max(temp1$Close), min(temp1$Close))
        
        tempMatrix[2, ] <- c(input$criptoNameComparative2, getMode(temp2$Close), mean(temp2$Close), 
            median(temp2$Close), sd(temp2$Close), max(temp2$Close), min(temp2$Close))

        colnames(tempMatrix) <- c("Criptomoeda", "Moda", "Media", "Mediana", "desvio padrão",
            "max", "min")

        tempMatrix
    })

    output$lineGraphComparative <- renderPlot({
        temp1 <- current_frame_comparative_1()
        temp2 <- current_frame_comparative_2()
        buildLineGraph2(temp1$Date, temp1$Close, temp2$Date, temp2$Close)
    })

    output$meanBarplot <- renderPlot({
        temp1 <- current_frame_comparative_1()
        temp2 <- current_frame_comparative_2()
        values <- c(mean(temp1$Close), mean(temp2$Close))

        # Rótulos para as barras (opcional)
        labs <- c(input$criptoNameComparative1, input$criptoNameComparative2)

        # Criar o gráfico de barras
        barplot(values, names.arg = labs, col = c("blue", "red"), main = "Média em USD")
    })

    output$scatteplot <- renderPlot({
        temp1 <- current_frame_comparative_1()
        temp2 <- current_frame_comparative_2()

        buildScatteplot(temp1$Date, temp1$Close, temp2$Close)
    })
}
