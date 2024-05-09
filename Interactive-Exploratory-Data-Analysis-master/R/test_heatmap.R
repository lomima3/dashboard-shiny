# Sample data for demonstration
set.seed(123)
finalInputData <- data.frame(
  Group = rep(c("A", "B", "C"), each = 10),
  Value = rnorm(30)
)

# Perform ANOVA test
model <- aov(Value ~ Group, data = finalInputData)
anova_result <- summary(model)

# Display ANOVA test results
print(anova_result)
















