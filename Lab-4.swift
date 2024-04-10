import Foundation

struct Location {
    let id: Int
    let type: String
    let name: String
    let rating: Int
}

struct City {
    let id: Int
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    let keywords: [String]
    var locations: [Location]
}

var cities: [City] = []

for i in 1...5 {
    let city = City(id: i,
                    name: "City \(i)",
                    description: "Description of City \(i)",
                    latitude: Double.random(in: -90...90),
                    longitude: Double.random(in: -180...180),
                    keywords: ["party", "sport", "music"],
                    locations: [])
    cities.append(city)
}

for i in 1...5 {
    let city = City(id: i + 5,
                    name: "Village \(i)",
                    description: "Description of Village \(i)",
                    latitude: Double.random(in: -90...90),
                    longitude: Double.random(in: -180...180),
                    keywords: ["seaside", "nature"],
                    locations: [])
    cities.append(city)
}

for i in 1...5 {
    let city = City(id: i + 10,
                    name: "Town \(i)",
                    description: "Description of Village \(i)",
                    latitude: Double.random(in: -90...90),
                    longitude: Double.random(in: -180...180),
                    keywords: ["seaside", "sport", "nature"],
                    locations: [])
    cities.append(city)
}

func searchCityByName(name: String) -> [City] {
    return cities.filter { $0.name.lowercased().contains(name.lowercased()) }
}

func searchCityByKeyword(keyword: String) -> [City] {
    return cities.filter { $0.keywords.contains(keyword.lowercased()) }
}

func calculateDistance(city1: City, city2: City) -> Double {
    let lat1 = city1.latitude
    let lon1 = city1.longitude
    let lat2 = city2.latitude
    let lon2 = city2.longitude
    
    let latDistance = lat1 - lat2
    let lonDistance = lon1 - lon2
    let distance = sin(latDistance * Double.pi / 180) * sin(latDistance * Double.pi / 180) + cos(lat1 * Double.pi / 180) * cos(lat2 * Double.pi / 180) * sin(lonDistance * Double.pi / 180) * sin(lonDistance * Double.pi / 180)
    
    let centralAngle = 2 * atan2(sqrt(distance), sqrt(1 - distance))
    
    let earthRadius = 6371.0 // in kilometers
    
    return earthRadius * centralAngle
}

func findClosestAndFarthestCity(fromUserCoordinates userCoordinates: (latitude: Double, longitude: Double)) {
    var closestCity: City?
    var farthestCity: City?
    var minDistance = Double.infinity
    var maxDistance = 0.0
    
    for city in cities {
        let distance = calculateDistance(city1: city, city2: City(id: 0, name: "", description: "", latitude: userCoordinates.latitude, longitude: userCoordinates.longitude, keywords: [], locations: []))
        if distance < minDistance {
            minDistance = distance
            closestCity = city
        }
        if distance > maxDistance {
            maxDistance = distance
            farthestCity = city
        }
    }
    
    print("Closest city to you: \(closestCity?.name ?? "Unknown")")
    print("Farthest city from you: \(farthestCity?.name ?? "Unknown")")
}

func findFarthestCities() -> (City, City) {
    var farthestCities: (City, City) = (cities[0], cities[1])
    var maxDistance: Double = 0
    
    for i in 0..<cities.count {
        for j in i+1..<cities.count {
            let distance = calculateDistance(city1: cities[i], city2: cities[j])
            if distance > maxDistance {
                maxDistance = distance
                farthestCities = (cities[i], cities[j])
            }
        }
    }
    
    return farthestCities
}

extension City {
    mutating func addLocation(location: Location) {
        locations.append(location)
    }
}

func citiesWithFiveStarRestaurants() -> [City] {
    return cities.filter { city in
        city.locations.contains(where: { $0.type == "restaurants" && $0.rating == 5 })
    }
}

func locationsSortedByRating(city: City) -> [Location] {
    return city.locations.sorted { $0.rating > $1.rating }
}

func citiesWithNumberOfFiveStarLocations() {
    for city in cities {
        let fiveStarLocations = city.locations.filter { $0.rating == 5 }
        print("\(city.name) has \(fiveStarLocations.count) locations with 5 star rating:")
        fiveStarLocations.forEach { location in
            print("- \(location.name)")
        }
    }
}

for i in 0..<cities.count {
    for j in 1...5 {
        let location = Location(id: j,
                                type: "restaurants",
                                name: "Restaurant \(j)",
                                rating: Int.random(in: 1...5))
        cities[i].addLocation(location: location)
    }
}

// Testing the functions
print("Search by name:")
print(searchCityByName(name: "city"))
print("\nSearch by keyword:")
print(searchCityByKeyword(keyword: "party"))

let userCoordinates = (latitude: 40.7128, longitude: -74.0060) // New York coordinates
findClosestAndFarthestCity(fromUserCoordinates: userCoordinates)

let farthestCities = findFarthestCities()
print("\nFarthest cities from each other: \(farthestCities.0.name) and \(farthestCities.1.name)")

print("\nCities with 5-star restaurants:")
print(citiesWithFiveStarRestaurants().map { $0.name })

let city = cities.first!
print("\nLocations in \(city.name) sorted by rating:")
print(locationsSortedByRating(city: city).map { "\($0.name) - \($0.rating) stars" })

print("\nCities with number of 5-star locations:")
citiesWithNumberOfFiveStarLocations()
