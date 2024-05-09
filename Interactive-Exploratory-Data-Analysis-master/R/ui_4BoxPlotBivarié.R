fluidPage(
  # supress error messages in app
  tags$style(
    type = 'text/css',
    ".shiny-output-error{ visibility: hidden;}",
    ".shiny-output-error:before { visibility:hidden; }"
  ),
  source("./ui_CustomError.R", local = T)[1],
  fluidRow(conditionalPanel(
    "output.ValPlots",
    box(withSpinner(plotlyOutput(
      "BoxPlot", height = 450, width = 850
    )), width = 10),
    box(uiOutput("BoxMeasure"), width = 2, uiOutput("BoxDimension")),
    box(downloadButton("downloadBoxPlotPDF", "Print PDF"))
    
  )),
  fluidRow(
    box(
      title = "Guide d'utilisation de boîte à moustaches bivariée",
      status = "info",
      solidHeader = TRUE,
      collapsible = TRUE,
      HTML("<ul>
                            <li><strong>Ce qu'elle montre :</strong> Chaque boîte à moustaches représente la distribution, la médiane, les quartiles et les valeurs aberrantes d'une variable différente.</li>
                            <li><strong>Valeurs élevées :</strong> Comparez les positions et les formes des boîtes à moustaches pour évaluer la relation entre les deux variables. Par exemple, si une boîte à moustaches est constamment plus élevée que l'autre, cela suggère une corrélation positive.</li>
                            <li><strong>Valeurs aberrantes :</strong> Recherchez les valeurs aberrantes dans chaque boîte à moustaches. Les valeurs aberrantes peuvent indiquer des valeurs inhabituelles ou extrêmes qui peuvent nécessiter des investigations supplémentaires, telles que des réponses inhabituelles des patients à un traitement.</li>
                             </ul>")
    )
  )
  
)