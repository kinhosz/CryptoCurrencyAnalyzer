library(shiny)

source("controllers/dashboardController.R")
source("controllers/comparativeController.R")

server <- function(input, output, session) {
    dashboardController(input, output, session)
    comparativeController(input, output, session)
}
