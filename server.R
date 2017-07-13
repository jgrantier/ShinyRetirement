# Define server logic for slider examples

library(ggplot2)
library(scales)
shinyServer(function(input, output) {
      

      moneyByAge <- reactive({
            req(input$expectedExpense,input$expectedIncome, input$curSavings, input$annualSavings)
            curAge <- input$workingYears[1]
            retAge <- input$workingYears[2]
            timeTilRetirement <- retAge-curAge
            endAge <- 100
            timeInRetirement <- endAge-retAge
            rateOfReturn <- ((1 + input$returnRate/100)/(1 + input$inflatRate/100))
            annualNetExpense <- 12*(input$expectedExpense-input$expectedIncome)
            total <- input$curSavings
            for(i in 1:timeTilRetirement) {
                  total <- rbind(total,(total[i] + input$annualSavings)*rateOfReturn )
            }
            
            for(j in 1:timeInRetirement) {
                  if (total[j+timeTilRetirement]>0) {
                        total <- rbind(total, (total[j+timeTilRetirement]-annualNetExpense)*rateOfReturn)
                  }
                  else {
                        endAge <- retAge + j-1
                        break
                  }
                  age <- curAge:endAge
            }
    rownames(age) <- c()
    rownames(total) <- c()
    data <- data.frame(cbind(age, total))
    data_frame <- setNames(data, c("age","total"))
      }) 
      #moneyByAge()[nrow(moneyByAge()),1] is just endAge from above, but variables can't be called outside the function
      output$message <- renderText({
            if (moneyByAge()[nrow(moneyByAge()),1]  == 100){
                  paste("Your money will last at least until you are 100 years old!  You could have $",format(moneyByAge()[nrow(moneyByAge()),2],digits=2, big.mark = "," )," to leave to your favorite people or charity!")
            }
            else{
                  paste("Your money will run out by the time you are " ,moneyByAge()[nrow(moneyByAge()),1] , " years old. Consider saving more each month or cutting your expenses in retirement.")
            }
            
      })
      output$message2 <- renderText({
            if (moneyByAge()[nrow(moneyByAge()),1]  == 100){
                  paste("Your money will last at least until you are 100 years old!  You could have $",format(moneyByAge()[nrow(moneyByAge()),2],digits=2, big.mark = "," )," to leave to your favorite people or charity!")
            }
            else{
                  paste("Your money will run out by the time you are " ,moneyByAge()[nrow(moneyByAge()),1] , " years old. Consider saving more each month or cutting your expenses in retirement.")
            }
            
      })
      
      output$total <- renderTable({
           cbind(Age = moneyByAge()[,1], Total = comma(moneyByAge()[,2]))
      })
      output$plot <-  renderPlot({
            
           
            require(scales)
          
           p <-  ggplot(moneyByAge(), aes(x=  moneyByAge()$age, y= moneyByAge()$total)) + 
                  geom_area( fill="blue", alpha=.2)+ 
                  geom_line()+
                  scale_y_continuous(labels = comma)+
                  labs(x = "Your Age", y = "Your Retirement Savings")
           print(p)
      })
})
