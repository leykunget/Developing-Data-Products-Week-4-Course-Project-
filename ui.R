
library(shiny)

shinyUI(
navbarPage("Developing Data Products Week 4 Assignment",
  tabPanel("Simple Regression Analysis",
  (fluidPage(
    titlePanel("Estimate Miles per Gallon (mpg) with Simple Regression Models (SRM)"),
    sidebarLayout(
     sidebarPanel(
        selectInput("variable", "Select Independent variables for SRM",
                c('cyl', 'disp', 'hp', 'drat','wt', 'qsec', 'vs', 'am', 'gear', 'carb')),
        checkboxInput("simple_model","show the model", value=FALSE),
        submitButton("Submit")
                                    
    ),
 mainPanel(
  h3("Simple Regression Model"),
  textOutput("model"),
  tabsetPanel(type = "tabs", 
        tabPanel("BoxPlot", plotOutput("simpleboxplot"),textOutput("simpletext")),
        tabPanel("Summary", verbatimTextOutput("simplesummary")),
        tabPanel("Residual Plots", plotOutput("simpleresidual"))
                                                
                                                
            )
          )
        )
                            
   ))),
               
   tabPanel("Multiple Regression Analysis",
        fluidPage(
         titlePanel("Multiple Regression model of mpg on other variables"),
         sidebarLayout(
         sidebarPanel(
          checkboxInput("multimodel","show regression model",value=FALSE),
            submitButton("Submit")
        ),
        mainPanel(
         h3("Multiple Regression Model(MRM)"),
            textOutput("fullmodel"),
             tabsetPanel(type = "tabs",
                    tabPanel("Model summary", verbatimTextOutput("multisummary")),
                    tabPanel("Residual Plots Full", plotOutput("multiresidual"))
                                                
                                                
                                                
                    )
                  )
                 )
                )
                        
     ),
     tabPanel("Data Description",
              h2("Motor Trend Car Road Tests"),
              hr(),
              h3("Description"),
              helpText("The data was extracted from the 1974 Motor Trend US magazine,",
                       " and comprises fuel consumption and 10 aspects of automobile design and performance",
                       " for 32 automobiles (1973-74 models)."),
              h3("Format"),
              p("A data frame with 32 observations on 11 variables.")
     )
)
)