library(shiny)

shinyUI(fluidPage(
 
  # Adding a sidebar
  sidebarLayout(
    sidebarPanel(
      
      # Letting user select which distribution they want
      selectInput("select", 
                  label = "Choose a distribution",
                  choices = c("Normal", "Chi Squared", "Student-t",
                              "F"),
                  selected = "Normal"),
      
      # Letting user decide how many draws (n)
      sliderInput("n",
                  "Pick a value for n:",
                  min = 10,
                  max = 100000,
                  value = 1000),
      
      # Letting user decide degrees of freedom ν
      sliderInput("df1",
                  "Pick a value for ν:",
                  min = 1,
                  max = 200,
                  value = 20),
      
      # Letting user decide degrees of freedom ω
      sliderInput("df2",
                  "Pick a value for ω:",
                  min = 1,
                  max = 200,
                  value = 20)
    ),

    # Defining our output to plot in the main panel from our server
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
