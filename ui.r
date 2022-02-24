library(shiny)

shinyUI(
    navbarPage("Developing Data Products Assignment",
               tabPanel("Simple Regression",
                        (fluidPage(
                            titlePanel("Predict Miles per Gallon (mpg) with Simple Regression Models"),
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput("variable", "Select Input for Simple Regression",
                                                c("am","cyl","hp","wt","disp","drat","qsec","gear","carb")),
                                    checkboxInput("simple_model","show simple model",value=FALSE),
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
               
               tabPanel("Multivariable Regression (Full)",
                        fluidPage(
                            titlePanel("Regression with All Variables for mpg Prediction"),
                            sidebarLayout(
                                sidebarPanel(
                                    checkboxInput("multimodel","show full regression model",value=FALSE),
                                    submitButton("Submit")
                                ),
                                mainPanel(
                                    h3("Multivariable Regression Model"),
                                    textOutput("fullmodel"),
                                    tabsetPanel(type = "tabs", 
                                                
                                                tabPanel("Summary Full", verbatimTextOutput("multisummary")),
                                                tabPanel("Residual Plots Full", plotOutput("multiresidual"))
                                                
                                                
                                                
                                                
                                                
                                                
                                    )
                                    
                                )
                            )
                        )
                        
               ),
               tabPanel("Multivariable Regression (Variable Selection)",
                        fluidPage(
                            titlePanel("Regression with Best Variables for mpg Prediction"),
                            sidebarLayout(
                                sidebarPanel(
                                    checkboxInput("show","Show/Hide Best Variable Subsets",value = FALSE),
                                    checkboxInput("variablenum","Show/Hide Best Variable Number",value = FALSE),
                                    checkboxInput("variables","Show/Hide Best Variables",value = FALSE),
                                    
                                    submitButton("Submit (it may take a while for processing)")
                                    
                                    
                                ),
                                mainPanel(
                                    h3("Best Subset Regression Model"),
                                    verbatimTextOutput("bestvariablesubsets"),
                                    verbatimTextOutput("variablenumber"),
                                    verbatimTextOutput("bestvariables"),
                                    
                                    tabsetPanel(type = "tabs", 
                                                
                                                tabPanel("Summary ", verbatimTextOutput("multisummary2")),
                                                tabPanel("Residual Plots", plotOutput("multiresidual2"))
                                                
                                                
                                                
                                    )
                                    
                                )
                            )
                        )
                        
               )
               
    ))