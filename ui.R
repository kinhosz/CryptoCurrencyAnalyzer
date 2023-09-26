library(shinydashboard)

source("pages/dashboardPage.R")
source("pages/comparativePage.R")

ui <- dashboardPage(
  dashboardHeader(title = "Criptocurrencies"),
  dashboardSidebar(
    sidebarMenu(
        menuItem("Dashboard", tabName="dashboard", icon = icon("dashboard")),
        menuItem("Comparação", tabName="comparative", icon = icon("bitcoin"))
    )
  ),
  dashboardBody(
    tabItems(
        tabItem(tabName = "dashboard", buildDashbordPage()),
        tabItem(tabName = "comparative", buildComparativePage())
    )
  )
)
