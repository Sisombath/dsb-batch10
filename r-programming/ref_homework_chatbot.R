#Chatbot for ordering Pizza
piz <- c("Margherita Pizza", "Pepperoni Pizza", "Vegetarian Delight", "BBQ Chicken Pizza", "Four Cheese Pizza")
dri <- c("Coke", "Diet Coke", "Lemonade", "Iced Tea", "Sparkling Water")
piz_price <- c(12.99, 14.49, 15.99, 16.49, 15.49)
dri_price <- c(2.49, 2.49, 2.99, 2.79, 2.99)

#Create data frame
piz_df <-data.frame( ID = 1:length(piz),
                     pizza = piz,
                     price = piz_price
)
dri_df <-data.frame( ID = 1:length(dri),
                     drinks = dri,
                     price = dri_price
)


##Create function for ordering
order <- function() {
  repeat {
    ##Display the menu
    print("Hi there! Welcome to Pizza Passion Bistro. Here is our pizza menu: ")
    print(piz_df)
    piz_input <- as.integer(readline("Enter Pizza id: "))
    piz_amount<- as.integer(readline("Amount: "))
    
    print("Here's our drink menu: ")
    print(dri_df)
    dri_input <- as.integer(readline("Enter Drink id: "))
    dri_amount<- as.integer(readline("Amount: "))
    
    ##Validation
    if ((dri_input %in% dri_df$ID) & (piz_input %in% piz_df$ID)) {
      ##Display customer bill
      print("Here's the bill: ")
      item <- c(piz_df$pizza[[piz_input]], 
                dri_df$drinks[[dri_input]])
      price <-c(piz_df$price[[piz_input]], 
                dri_df$price[[dri_input]])
      amount <- c(piz_amount, dri_amount)
      total <- price*amount
      bill_df <- data.frame(item, price, amount, total)
      total <- sum(total)
      print(bill_df)
      cat("_____________________________________", "\n", "Total: ", total)
    } else {
      print("Please enter the valid id")
    } 
    
    reorder <- tolower(readline("Do you need to order anything else (Yes/No): "))
    if (reorder != "yes") {
      print("Thank you for dining with us")
      break
    }
  }
}

order()