library(shiny)
shinyUI(fluidPage(

      sidebarLayout(
            sidebarPanel(
                 
                  h4("Working Years"),
             
                  sliderInput("workingYears", "Choose current age and age at retirement:",
                              min = 0, max = 100, value = c(20,65)),
                  numericInput("curSavings", "Current retirement savings:", 
                              min=0, max=1000000, value=10000, step=1000),
                  numericInput("annualSavings", "Additional amount you save each year:", 
                              min=0, max=1000000, value=6000, step=1000),
                  sliderInput("returnRate", "Expected return on investment (%):", 
                              min = 0, max = 15, value = 6, step= 0.5),
                  sliderInput("inflatRate", "Expected percent inflation(%):", 
                              min = 0, max = 10, value = 2, step= 0.5),
              h4("Retirement Years"),
                  numericInput("expectedIncome", "Monthly expected pension:", 
                               min=0, max=20000, value=1000, step=500),
                  numericInput("expectedExpense", "Monthly expected expenses:", 
                               min=0, max=1000000, value=5000, step=1000),
                submitButton("Submit")


            ),
      mainPanel(
            tabsetPanel(type = "tabs",
                  tabPanel(
                        h5("Graph of Results") ,
                        br(),
                        textOutput("message"),
                        br(),
                        plotOutput("plot")
                        ),
                  tabPanel(
                        h5("Table of Results"),
                        br(),
                        textOutput("message2"),
                        br(),
                        tableOutput("total")
                        ),                        
                  tabPanel(
                        h5("Directions"),
                        br(),
                        p("This simple program calculates the amount you will have each year in retirement savings."),
                        h4("Entry Instructions"),
                        h5("Choose current age and age at retirement:"),
                        p("The left slider should be at your current age.  The right slider should be at your chosen retirement age."),
                        h5("Current retirement savings:"),
                        p("Enter the amount you have saved for retirement right now."),
                        h5("Additional amount you save each year:"),
                        p("Enter the additional amount you save each year."),
                        h5("Expected return on investment (%):"),
                        p("Choose the percent return you expect on your investments."),
                        h5("Expected percent inflation(%):"),
                        p("Choose the inflation rate you wish to use for return calculations."),
                        h5("Monthly expected pension:"),
                        p("Enter here your expected monthly income from all other sources, like Social Security, pensions or annuities."),
                        h5("Monthly expected expenses:"),
                        p("Enter here your expected monthly expenses in retirement."),
                        h5("Submit"),
                        p("Click Submit when you are done with your entries."),
                        h4("Explanation of Results"),
                        p("This program calculates the amount of money you will have each year until you are 100 years old or until you run out of money."),
                        p("The first tab gives you a graph of your savings and the second gives you the details in a table.")
                  )
            )
      )
      )
))
