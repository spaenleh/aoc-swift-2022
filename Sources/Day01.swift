import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n\n").map {
      $0.split(separator: "\n").compactMap { Int($0) }
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Int {
    // Calculate the sum of the first set of input data
    let summedCalories = entities.map { $0.reduce(0, +) }
    return summedCalories.max() ?? 0
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Int {
    let summedCalories = entities.map { $0.reduce(0, +) }
    let orderedCalories = summedCalories.sorted().reversed()
    let top3 = orderedCalories.prefix(3)
    return top3.reduce(0, +)
  }
}
