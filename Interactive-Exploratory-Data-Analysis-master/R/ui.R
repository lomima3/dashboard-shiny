
library(shiny)
library(shinyjs)
library(shinydashboard)
library(plotly)
library(DT)
library(xlsx)
library(evaluate)
library(shinycssloaders)
library(highcharter)
library(cowplot)
library(magick )
library(ggplot2)
library(tseries)  
library(moments)
library(plotly)
library(stats)

ui = dashboardPage(title = "Dashboard",
  skin = "blue",
  dashboardHeader(title = div(img(src="Title.png",height=50,width=150,align = "left"), 
                              "Dashboard"),
                  tags$li(tags$script(),
                          class = "dropdown"),
                  
                  titleWidth = 250),
    
  # ***************************Dashboard Side Bar***************************
  dashboardSidebar(
    width = 250,
    sidebarMenu(id = "MenuTabs",
      menuItem(tags$span("Acceuil", style = "margin-left: 5px;"), tabName = "Acceuil", icon = icon("home")),
      menuItem(tags$span("Téléchargement", style = "margin-left: 5px;"), tabName = "Téléchargement", icon = icon("file")),
      menuItem(tags$span("Analyse univarié", style = "margin-left: 5px;"), tabName = "Univarié", icon = icon("bar-chart")),
      menuItem(tags$span("Diagramme de dispersion", style = "margin-left: 5px;"), tabName = "ScatterPlot", icon = icon("dot-circle-o")),
      menuItem(tags$span("Diagramme en boîte bivarié", style = "margin-left: 5px;"), tabName = "BoxPlotBivarié", icon = icon("sliders")),
      menuItem(tags$span("Diagramme à barres groupées bivarié", style = "margin-left: 5px;"), tabName = "BarBivarié", icon = icon("bar-chart")),
      menuItem(tags$span("Histogramme groupé bivarié", style = "margin-left: 5px;"), tabName = "HistogrameBivarié", icon = icon("area-chart")),

      menuItem(tags$span("Diagramme en boîte multivarié", style = "margin-left: 5px;"), tabName = "MultiBoxPlot", icon = icon("sliders")),
      menuItem("Test de Normalité", tabName = "Normalité", icon = icon("info-circle")),
      menuItem("Test de Corrélation", tabName = "Corrélation", icon = icon("info-circle")),
      menuItem("Test d'Indépendance", tabName = "Indépendance", icon = icon("info-circle")),
      menuItem("Classification", tabName = "Classification", icon = icon("info-circle"))
      
      
      
    )
  ),
  # ***************************Dashboard Body***************************
  dashboardBody(
    tabItems(
      # ***************************Data Source***************************
      tabItem(tabName = "Acceuil",
              source("./ui_0Acceuil.R", local = T)[1]),
      # ***************************Data Source***************************
      tabItem(tabName = "Téléchargement",
              source("./ui_1Téléchargement.R", local = T)[1]),
      # ***************************Univariate Analysis***************************
      tabItem(tabName = "Univarié",
              source("./ui_2Univarié.R", local = T)[1]),
      # ***************************Bi Variate Scatter Plot***************************
      tabItem(tabName = "ScatterPlot",
              source("./ui_3ScatterPlot.R", local = T)[1]),
      # ***************************Bi Variate Box Plot***************************
      tabItem(tabName = "BoxPlotBivarié",
              source("./ui_4BoxPlotBivarié.R", local = T)[1]),
      # ***************************Bi Variate Group Bar Plot***************************
      tabItem(tabName = "BarBivarié",
              source("./ui_5BarBivarié.R", local = T)[1]),
      # ***************************Bi Variate Group Histogram***************************
      tabItem(tabName = "HistogrameBivarié",
              source("./ui_6HistogrameBivarié.R", local = T)[1]),
      # ***************************Multi Variate Box Plot***************************
      tabItem(tabName = "MultiBoxPlot",
              source("./ui_8MultiBoxPlot.R", local = T)[1]),
      # ***************************Multi Variate Box Plot***************************
      tabItem(tabName = "Normalité",
              source("./ui_9Normalité.R", local = T)[1]),
      
      tabItem(tabName = "Corrélation",
              source("./ui_10Corrélation.R", local = T)[1]),
      
      tabItem(tabName = "Indépendance",
              source("./ui_11Indépendance.R", local = T)[1]),
      
      tabItem(tabName = "Classification",
              source("./ui_12Classification.R", local = T)[1])
    )
  )
)

