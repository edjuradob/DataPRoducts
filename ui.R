shinyUI(pageWithSidebar(  
  
  headerPanel("Example plot"),  
  sidebarPanel(    
    
    selectizeInput(
    'buying', label = "Buying price", choices = c("vhigh", "high", "med", "low")
  ),
  fluidRow(verbatimTextOutput("Value_buying")),
  selectizeInput(
    'maint', label = "Maintanance price", choices = c("vhigh", "high", "med", "low"),
    options = list(create = TRUE)
  ),
  selectizeInput(
    'doors', label = "Number of Doors", choices = c("2", "3", "4", "5more"),
    options = list(create = TRUE)
  ),
  selectizeInput(
    'persons', label = "Number of persons", choices = c( "2", "4", "more"),
    options = list(create = TRUE)
  ),
  selectizeInput(
    'lug_boot', label = "Luggage space", choices = c("small", "med", "big"),
    options = list(create = TRUE)
  ),
  selectizeInput(
    'safety', label = "safety", choices = c( "2", "4", "more"),
    options = list(create = TRUE)
  )
  ),
  mainPanel(
#     h3('Results of prediction'),
#     h4('You entered'),
#     verbatimTextOutput("buying"),
    h4('Resulted in a prediction of '),
    verbatimTextOutput("prediction")
  )
))