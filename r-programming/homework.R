# Homework
# chatbot order pizza
pizza <- c("Seafood Pizza", "Four Cheese Pizza", "Pepperoni Pizza", "Vegetarian Pizza", "Margherita Pizza")
drink <- c("Pepsi", "Coke", "Sprite", "Orange Juice", "Water")
pizza_price <- c(15.00, 13.00, 14.00, 12.00, 11.00)
drink_price <- c(2.00, 2.00, 2.00, 3.00, 1.00)

## create dataframe
food_df <- data.frame(ID = 1:length(pizza),
                      pizza,
                      pizza_price)
drink_df <- data.frame(ID = 1:length(drink),
                       drink,
                       drink_price)

## create function
pizza <- function() {
    print("Hello! Welcome to Tom's Pizza")
    print("_____________________________")
    print(food_df)
    
    pizza_menu <- as.integer(readline("Your pizza id: "))
    f_amount <- as.integer(readline("Amount: "))
    print(drink_df)
    
    drink_menu <- as.integer(readline("Your drink id: "))
    d_amount <- as.integer(readline("Amount: "))
    
    if ((pizza_menu %in% food_df$ID) & (drink_menu %in% drink_df$ID)) {
      print("Here is your orders : ")
      print("________________________________")
      
      items <- c(food_df$pizza[[pizza_menu]], 
                       drink_df$drink[[drink_menu]])
      price <- c(food_df$pizza_price[[pizza_menu]], 
                      drink_df$drink_price[[drink_menu]])
      
      amount <- c(f_amount, d_amount)
      
      total <- price * amount
      
      bill_df <- data.frame(items, price, amount, total)
      
      total <- sum(total)
      
      print(bill_df)
      cat("_____________________________________", "\n", "Total: $ ", total)
    } else {
      print("Please enter the valid id")
    } 
}

pizza()









