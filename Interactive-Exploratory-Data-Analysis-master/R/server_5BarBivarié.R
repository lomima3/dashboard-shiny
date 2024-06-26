# ************************************Bi Variate Group Bar Plot************************************
# **************************Select Inputs**************************
output$GBarDimension1 = renderUI({
  selectInput("GBarDimension1", "Sélectionner Dimension1", 
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Variable qualitative")]), "Variable qualitative")
})

output$GBarDimension2 = renderUI({ 
  selectInput("GBarDimension2", "Sélectionner Dimension2", 
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Variable qualitative")]), "Variable qualitative") 
})

# **************************Reactive Variable**************************
dataInput4 = reactive({
  if(is.null(input$GBarDimension1) & is.null(input$GBarDimension2)) {
    return(NULL)
  } else if (input$GBarDimension1 != input$GBarDimension2) {
    inputdata4 = finalInputData() %>% select(one_of(c(input$GBarDimension1,input$GBarDimension2))) 
    colnames(inputdata4) = c("XVar", "YVar")
    return(inputdata4)
  } else if (input$GBarDimension1 == input$GBarDimension2) {
    inputdata4 = finalInputData() %>% select(one_of(c(input$GBarDimension1,input$GBarDimension2))) 
    colnames(inputdata4) = c("XVar")
    inputdata4$YVar = inputdata4$XVar
    return(inputdata4)
  }
})

# **************************Outputs**************************
output$GBarPlot = renderPlotly({
  if(is.null(dataInput4())) {
    return()
  } else {
    dataInput4() %>% 
      count(XVar, YVar) %>% 
      group_by(XVar) %>% 
      mutate(percentage = n/sum(n) * 100) %>%  # Calculate percentages
      arrange(desc(percentage)) %>%  # Sort by percentage in descending order
      plot_ly(x = ~ reorder(XVar, percentage), y = ~ percentage, color = ~ YVar, type = "bar") %>% 
      layout(title = paste0("Distribution de ", input$GBarDimension1, " à travers ", input$GBarDimension2),
             xaxis = list(title = input$GBarDimension1, categoryorder = "array", categoryarray = ~ XVar), 
             yaxis = list(title = "Pourcentage (%)"), legend = FALSE)
  }
})


output$downloadGBarPlotPDF <- downloadHandler(
  filename = function() {
    "grouped_bar_plot.pdf"
  },
  content = function(file) {
    # Prepare data for plotting
    plot_data <- dataInput4() %>%
      count(XVar, YVar) %>%
      group_by(XVar) %>%
      mutate(percentage = n / sum(n) * 100) %>%  # Calculate percentages
      arrange(desc(percentage))  # Sort by percentage in descending order
    
    # Create grouped bar plot using ggplot2
    gbar_plot <- ggplot(plot_data, aes(x = reorder(XVar, percentage), y = percentage, fill = YVar)) +
      geom_bar(stat = "identity") +
      labs(title = paste0("Distribution de ", input$GBarDimension1, " à travers ", input$GBarDimension2),
           x = input$GBarDimension1,
           y = "Pourcentage (%)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_fill_manual(values = c("blue", "red"))  # Adjust fill colors as needed
    
    # Save the plot into the PDF file
    ggsave(file, plot = gbar_plot, device = "pdf", width = 11, height = 8.5)
  }
)



