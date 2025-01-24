# Homework
# pao ying soup game


# create pao ying soup game function

game <- function(rounds = 10) {
  
# play 10 round
  win  <- 0
  tie  <- 0
  lose <- 0
  for (i in 1:rounds) {
  
# validate input
  hands       <- c("hammer","scissor","paper")
  bot_hands   <- sample(hands, 1)
  user_hands  <- readline("Choose your hand (hammer,paper,scissor or quit) : ")
  
  if (user_hands == "quit") {
    print("Goodbye!")
    break
  } else if (!user_hands %in% hands) {
      Print("Invalid choice. Please ENTER hammer,paper,scissor")
  }
  
# win tie lose
  
  if (user_hands == bot_hands) {
    result <- "It's a tie !!"
    tie = tie + 1
  } else if ((user_hands == "hammer"  & bot_hands == "scissor") | 
            (user_hands == "paper"   & bot_hands == "hammer")  |
            (user_hands == "scissor" & bot_hands == "paper"))   {
    result <- "You're Win :)"
    win = win + 1
  } else {
    result <- "You're lose :("
    lose = lose + 1
  }
  
## show result
  print(paste0("Bot choose:",bot_hands))
  print(result)
}

## calculate final score
final_score <- win - lose
  if (final_score < 0) {
    final_result <- "you lost"
  } else if (final_score == 0) {
      final_result <- "It's tie"
  } else { 
    final_result <- " You won"
}

## show the final score
print(paste0("You won ",win," round(s)"))
print(paste0("You tie ",tie," round(s)"))
print(paste0("You lose ",lose," round(s)"))
print("The final is ...")
print(final_result)
}


game()

  

