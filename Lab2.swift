import Foundation
// -----------------
// Functions

func minValue(_ a: Int, _ b: Int) -> Int {
    if a < b {
        return a
    }
    return b
}

func returnLastDig(_ a: Int) -> Int {
    return a % 10
}

func divides(_ a: Int, _ b: Int) -> Bool {
    return a % b == 0
}

func countDivisors(number: Int) -> Int {
    var divNumber = 0
    for i in 1...number / 2 {
        if divides(number, i) {
            divNumber += 1
        }
    }
    return divNumber + 1
}

func isPrime(number: Int) -> Bool {
    return countDivisors(number: number) == 2
}

print(minValue(10, 100))
print(returnLastDig(100))

print(divides(7, 3)) // false - 7 is not divisible by 3
print(divides(8, 4)) // true - 8 is divisible by 4

print(isPrime(number: 3))  // true
print(isPrime(number: 8))  // false
print(isPrime(number: 13)) // true


// -----------------
// Closures

func smartBart(_ n: Int, closure: () -> Void) {
    for _ in 1...n {
        closure()
    }
}

let messageClosure = {
    print("I will pass this course with the best mark because Swift is great!")
}

smartBart(3, closure: messageClosure)

let numbers = [10, 16, 18, 30, 38, 40, 44, 50]
let multiplesOf4 = numbers.filter { $0 % 4 == 0 }
print("Multiples of 4: \(multiplesOf4)")

let largestNumber = numbers.reduce(Int.min) { max($0, $1) }
print("Largest number: \(largestNumber)")

var strings = ["Gdansk", "University", "of", "Technology"]
let joinedString = strings.reduce("") { $0.isEmpty ? $1 : $0 + " " + $1 }
print("Joined String: \(joinedString)")

let oddSquaresSum = numbers.filter { $0 % 2 != 0 }.map { $0 * $0 }.reduce(0, +)
print("Sum of squares of odd numbers: \(oddSquaresSum)")

// -----------------
// Tuples 

func minmax(_ a: Int, _ b: Int) -> (min: Int, max: Int) {
    return (min(a, b), max(a, b))
}

let result = minmax(10, 5)
print("Minimum: \(result.min), Maximum: \(result.max)")

var stringsArray = ["gdansk", "university", "gdansk", "university", "university", "of", "technology", "technology", "gdansk", "gdansk"]

func countOccurrences(_ strings: [String]) -> [(String, Int)] {
    var countedStrings: [(String, Int)] = []
    
    for string in Set(strings) {
        let count = strings.filter { $0 == string }.count
        countedStrings.append((string, count))
    }
    
    return countedStrings
}

let countedStrings = countOccurrences(stringsArray)
print("Counted Strings: \(countedStrings)")


// -----------------
// Enums

enum Day: Int {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
    
    func emoji() -> String {
        switch self {
        case .monday:
            return "🌞 Monday"
        case .tuesday:
            return "🌟 Tuesday"
        case .wednesday:
            return "🌈 Wednesday"
        case .thursday:
            return "🚀 Thursday"
        case .friday:
            return "🎉 Friday"
        case .saturday:
            return "🌈 Saturday"
        case .sunday:
            return "🌞 Sunday"
        }
    }
}

let currentDay = Day.thursday
print("Today is \(currentDay.emoji())")
