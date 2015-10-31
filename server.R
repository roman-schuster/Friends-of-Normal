library(shiny)

# Defining a long sequence to evaluate PDF at
sequence <- seq(-1000, 1000, by = .01)
# defined outside of shinyServer for efficiency

shinyServer(function(input, output) {

  # Our plot to output to the UI
  output$distPlot <- renderPlot({
    
    # Deciding which distribution to use from input with switch()
    chosenDistribution <- switch(input$select,
        "Normal" = rnorm(input$n),
        "Chi Squared" = rchisq(input$n, df = input$df1),
        "Student-t" = rt(input$n, df = input$df1),
        "F" = rf(input$n, df1 = input$df1, df2 = input$df2))
    
    # And deciding which distribution to run the sequence on
    chosenPDF <- switch(input$select,
        "Normal" = dnorm(sequence),
        "Chi Squared" = dchisq(sequence, df = input$df1),
        "Student-t" = dt(sequence, df = input$df1),
        "F" = df(sequence, df1 = input$df1, df2 = input$df2))
    
    # Deciding which header to give our plot from input
    chosenMain <- switch(input$select,
        "Normal" = 'pdf of N(n, 0, 1) distribution',
        "Chi Squared" = 'pdf of χ²(ν) distribution',
        "Student-t" = 'pdf of t(ν) distribution',
        "F" = 'pdf of F(ν, ω) distribution')
    
    # Deciding which x-labl to give our plot from input
    chosenxlab <- switch(input$select,
        "Normal" = 'realization x of X~N(n, 0, 1)',
        "Chi Squared" = 'realization x of X~χ²(ν)',
        "Student-t" = 'realization x of X~t(ν)',
        "F" = 'realization x of X~F(ν, ω)')

    # Creating the histogram with the chosen distribution
    hist(chosenDistribution, probability = T, col = 'ivory3', 
         border = 'white', main = chosenMain, xlab = chosenxlab)
    # Adding a line plot of the chosen distribution's PDF
    points(sequence, chosenPDF, type = 'l', col = 'indianred4')
  })
})
