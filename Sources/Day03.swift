import Algorithms

struct RuckSack {
  var contents: Substring

  enum RuckSackError: Error {
    case NoDuplicate
  }

  var duplicatedItem: Character? {
    let half = contents.count / 2
    let firstPart = Set(Array(contents).prefix(upTo: half))
    let second = Set(Array(contents).suffix(from: half))

    return firstPart.intersection(second).first
  }
}

struct GroupBadge {
  typealias Element = StringProtocol
  var rucksacks: [any Element]
  var badge: Character? {
    let initialSack = Set(rucksacks[0])
    return rucksacks[1...].reduce(into: initialSack, { $0 = Set(Array($1)).intersection($0) })
      .first
  }
}

func getPriority(_ letter: Character) -> Int {
  if letter.isLowercase {
    return Int((letter.asciiValue ?? 97) - 96)
  } else {
    // here we need to add 26 so "A" has value 27
    return Int((letter.asciiValue ?? 65) - 64) + 26
  }
}

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // add here any computed values useful for the challenge
  var rucksacks: [RuckSack] {
    data.split(separator: "\n").map { RuckSack(contents: $0) }
  }

  var badges: [Character] {
    data.split(separator: "\n").chunks(ofCount: 3).map { GroupBadge(rucksacks: Array($0)).badge }
      .compactMap { $0 }
  }

  func part1() -> Int {

    // get the duplicated item in each rucksack
    let duplicatedItems = rucksacks.map { $0.duplicatedItem }.compactMap { $0 }

    // compute the priority of each duplicated item
    let priorities = duplicatedItems.map(getPriority)
    // sum of the priorities
    return priorities.reduce(0, +)
  }

  func part2() -> Int {
    // chunk the rucksacks by 3
    return badges.map(getPriority).reduce(0, +)
  }
}
