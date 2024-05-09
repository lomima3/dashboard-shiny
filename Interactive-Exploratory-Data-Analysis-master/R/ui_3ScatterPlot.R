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
      "ScatterPlot", height = 450, width = 850
    )), width = 10),
    box(uiOutput("Measure1"), width = 2, uiOutput("Measure2")
        ),
    box(downloadButton("downloadScatterPDF", "Print ScatterPlot"))

  )),
  fluidRow(
    box(
      title = "Guide d'utilisation de la carte thermique",
      status = "info",
      solidHeader = TRUE,
      collapsible = TRUE,
      HTML("<ul>
                            <li><strong>Ce qu'elle montre :</strong> Une représentation visuelle des données utilisant des couleurs, où chaque couleur représente une valeur différente.</li>
                            <li><strong>Valeurs élevées :</strong> Dans une carte thermique, les couleurs plus sombres représentent généralement des valeurs plus élevées des données visualisées. Par exemple, si la carte thermique représente les lectures de pression artérielle des patients, des teintes plus sombres pourraient indiquer des niveaux de pression artérielle plus élevés.</li>
                            <li><strong>Valeurs plus faibles :</strong>  À l'inverse, les couleurs plus claires dans une carte thermique représentent des valeurs plus faibles.</li>
                             </ul>")
    ),
    box(
      title = "Guide d'utilisation du graphe de dispersion",
      status = "info",
      solidHeader = TRUE,
      collapsible = TRUE,
      HTML("<ul>
                            <li><strong>Ce qu'elle montre :</strong>Les relations entre deux variables en traçant des points de données individuels sur un graphique.</li>
                            <li><strong>Interprétation :</strong> Recherchez des motifs tels que des amas de points, qui peuvent indiquer des groupes de patients présentant des caractéristiques similaires ou des réponses au traitement similaires.</li>
                             </ul>")
    )
    
    
    
  )
)