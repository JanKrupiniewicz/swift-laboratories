import Foundation

// Game Object
class HangmanGame {
    var wordToGuess: String
    var guessedLetters: [Character]
    var triesLeft: Int
    
    init(word: String, tries: Int) {
        self.wordToGuess = word
        self.guessedLetters = Array(repeating: "_", count: word.count)
        self.triesLeft = tries
        
        for (index, char) in word.enumerated() {
            if char == " " {
                guessedLetters[index] = " "
            }
        }
    }
    
    func drawBoard() {
        var displayWord = ""
        for (index, char) in wordToGuess.enumerated() {
            if char == " " {
                displayWord += " "
            } else {
                displayWord += String(guessedLetters[index])
            }
            displayWord += " "
        }
        print("Word: \(displayWord)")
        print("Tries left: \(triesLeft)")
    }
    
    func guess(letter: Character) -> Int {
        if wordToGuess.contains(letter) {
            for (index, char) in wordToGuess.enumerated() {
                if char == letter {
                    guessedLetters[index] = letter
                }
            }
            if !guessedLetters.contains("_") {
                print("Congratulations! You guessed the word: \(wordToGuess)")
                return 1
            }
        } else {
            triesLeft -= 1
            print("Incorrect guess. Try again.")
            if triesLeft == 0 {
                print("Game over! The word was: \(wordToGuess)")
                return 1
            }
        }
        drawBoard()
        return 0
    }
}

// Words
struct WordProvider {
    static func getRandomWord(category: String) -> String {
        switch category {
            case "cities":
                let cities = ["Paris", "London", "New York", "Tokyo", "Rome"]
                return cities.randomElement() ?? "Unknown"
            case "movies":
                let movies = ["Inception", "Interstellar", "The Godfather", "Pulp Fiction", "The Shawshank Redemption"]
                return movies.randomElement() ?? "Unknown"
            case "books":
                let books = ["To Kill a Mockingbird", "1984", "The Great Gatsby", "The Catcher in the Rye", "Harry Potter"]
                return books.randomElement() ?? "Unknown"
            default:
                return "Unknown"
        }
    }
}

// Levels
enum Difficulty {
    case easy, medium, hard
}

struct GameManager {
    func manageInput() {
        while(true) {
            var validInput = true
            var diff: Difficulty = .easy // Default to easy difficulty
            
            print("Please Input Difficulty [easy, medium, hard]")
            if let difficulty = readLine() {
                if difficulty == "easy" {
                    diff = .easy
                } else if difficulty == "medium" {
                    diff = .medium
                } else if difficulty == "hard" {
                    diff = .hard
                } else {
                    validInput = false
                }
            } else {
                validInput = false
            }
            
            print("Please Input Category [cities, movies, books]")
            if let category = readLine() {
                if category != "cities" && category != "movies" && category != "books" {
                    validInput = false
                } else {
                    playHangman(category: category, difficulty: diff)
                    break
                }
            } else {
                validInput = false
            }
            
            if !validInput {
                print("Please provide valid input.")
            }
        }
    }
    
    func playHangman(category: String, difficulty: Difficulty) {
        var tries = 0
        switch difficulty {
            case .easy:
                tries = 10
            case .medium:
                tries = 7
            case .hard:
                tries = 5
        }
        
        let wordToGuess = WordProvider.getRandomWord(category: category).uppercased()
        let hangmanGame = HangmanGame(word: wordToGuess, tries: tries)
        
        print("Welcome to Hangman!")
        hangmanGame.drawBoard()
        
        while hangmanGame.triesLeft > 0 {
            print("Enter a letter:")
            if let input = readLine(), let letter = input.uppercased().first {
                let gameFinished =  hangmanGame.guess(letter: letter)
                if gameFinished == 1 {
                    break   
                }
            }
        }
    }
}

let gameManager = GameManager()
gameManager.manageInput()
