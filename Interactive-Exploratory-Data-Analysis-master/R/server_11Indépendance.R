


output$Collonne44 = renderUI({
  selectInput("Collonne44", "Collonne44", 
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Variable quantitative")]), "Variable quantitative")
})

output$Collonne55 = renderUI({
  selectInput("Collonne55", "Collonne55", 
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Variable quantitative")]), "Variable quantitative")
})
# **************************Reactive Variable**************************
dataInput200 = reactive({
  
  if (is.null(input$Collonne44) & is.null(input$Collonne55)) {
    return(NULL)
  } else if (input$Collonne44 != input$Collonne55) {
    inputdata200 = finalInputData() %>% select(one_of(c(input$Collonne44,input$Collonne55)))
    colnames(inputdata200) = c("XVar", "YVar")
    return(inputdata200)
  } else if(input$Collonne44 == input$Collonne55) {
    inputdata200 = finalInputData() %>% select(one_of(c(input$Collonne44,input$Collonne55)))
    colnames(inputdata200) = c("XVar")
    inputdata200$YVar = inputdata200$XVar
    return(inputdata200)
  }
})
# **************************Outputs**************************
output$testResult3 <- renderText({
  req(input$PrintTest3, dataInput200())
  
  # Perform the selected test based on user input
  result_text7 <- NULL

  if (input$PrintTest3 == "Test de Student") {
    result_text7 <- t.test(dataInput200()$XVar, dataInput200()$YVar)

  } else if (input$PrintTest3 == "Test du Khi-deux (χ²)") {
    result_text7 <- chisq.test(dataInput200()$XVar, dataInput200()$YVar)

  } else if (input$PrintTest3 == "Test de Fisher") {
    result_text7 <- var.test(dataInput200()$XVar, dataInput200()$YVar)

  } 
  print(result_text7)
  
  
  # Format the result for display with HTML tags
  if (!is.null(result_text7)) {
    result_text7 <- paste("Test Name: <strong>", input$PrintTest3, "</strong><br>",
                         "p-value: <strong>", format(result_text7$p.value, digits = 3), "</strong><br>",
                         "Test Statistic: <strong>", format(result_text7$statistic, digits = 3), "</strong><br>")

    
    # Use HTML function to interpret HTML tags
    HTML(result_text7)
  } else {
    "No result available."
  }
})


# Output for ANOVA test result
output$anovaBox <- renderText({
  req(dataInput200())
  
  # Perform ANOVA test
  model <- aov(YVar ~ XVar, data = dataInput200())
  anova_result <- summary(model)
  
  print(anova_result)
  
  
  anova_text <- paste(
    "Degrees of Freedom (numerator): <strong>", anova_result$Df[1], "</strong><br>",
    "Degrees of Freedom (denominator): <strong>", anova_result$Df[2], "</strong><br>",
    "Sum of Squares: <strong>", format(anova_result$`Sum Sq`[1], digits = 3), "</strong><br>",
    "Mean Squares: <strong>", format(anova_result$`Mean Sq`[1], digits = 3), "</strong><br>",
    "F value: <strong>", format(anova_result$`F value`[1], digits = 3), "</strong><br>",
    "p-value: <strong>", format(anova_result$`Pr(>F)`[1], digits = 3), "</strong><br>"
  )
  # Use HTML function to interpret HTML tags
  HTML(anova_text)
})

