import Foundation

// -----------------
// Strings and Text
var n1 = 5
var n2 = 10
print("\(n1) + \(n2) = \(n1 + n2)")

var pg = "Gdansk University of Technology"
for char in pg {
  if(char == "n") {
    print("⭐️", terminator: "")
  } else {
    print(char, terminator: "")
  }
}

print("\n")
var name = "Jan Krupiniewicz"
for char in name.reversed() {
  print(char, terminator: "")
}

// -----------------
// Control Flow
print("\n")
for _ in 1...11 {
  print("I will pass this course with best mark, because Swift is great!")
}

print("\n")
var itr_squeares = 10
for i in (1...itr_squeares) {
  print("\(i*i)", terminator: " ")
}

print("\n")
for i in (1...itr_squeares) {
  for i in (1...itr_squeares) {
    print("@", terminator: "")
  }
  print("\n")
}

// -----------------
// Arrays
var numbers = [5, 10, 20, 15, 80, 13]
var max_n = 0
for i in 0..<numbers.count {
  if(max_n < numbers[i]) {
    max_n = numbers[i]
  }
}
print("\(max_n)")

var numbers2 = [5, 10, 20, 15, 80, 13]
for number in numbers2.reversed() {
    print(number, terminator: " ")
}

print("\n")
let allNumbers = [10, 20, 10, 11, 13, 20, 10, 30]
var unique = Array<Int>()
 
for i in 0..<allNumbers.count {
  let currNumber = allNumbers[i]
  var check = 1 
  for j in 0..<allNumbers.count {
    if (j != i) {
      if(currNumber == allNumbers[j]) {
        check = 0
      }
    }
  }
  if (check != 0) {
    unique.append(currNumber)
  }
}

for number in unique {
    print(number, terminator: " ")
}

// -----------------
// Sets
let number = 10
var divisors = Set<Int>()

for i in 1 ... number {
  if (number%i == 0) {
    divisors.insert(i)
  }
}
print("Divisors = \(divisors)")

// -----------------
// Dictionaries
let flights: [[String: String]] = [
    [
        "flightNumber" : "AA8025",
        "destination" : "Copenhagen"
    ],
    [
        "flightNumber" : "BA1442",
        "destination" : "New York"
    ],
    [
        "flightNumber" : "BD6741",
        "destination" : "Barcelona"
    ]
]

var flightNumbers = [String]()
for flight in flights {
    if let flightNumber = flight["flightNumber"] {
        flightNumbers.append(flightNumber)
    }
}
print("FlightNumbers = \(flightNumbers)")

var fullName: [[String: String]] = []
let names = ["Hommer", "Lisa", "Bart"]

for name in names {
    fullName.append(["Simson": name])
}

print("FullName = \(fullName)")