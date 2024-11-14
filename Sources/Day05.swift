import Algorithms
import Foundation

struct CrateStack: CustomStringConvertible, Equatable {
  var stack: [String] = [String]()

  var description: String {
    String(stack.joined(by: " "))
  }

  var topCrate: String {
    stack.last ?? ""
  }

  mutating func add(_ crate: String) {
    stack.append(crate)
  }

  mutating func add(allOf crates: [String]) {
    stack.append(contentsOf: crates)
  }

  mutating func remove() -> String {
    stack.popLast()!
  }

  mutating func remove(count: Int) -> [String] {
    var crates = [String]()
    for _ in 0..<count {
      crates.append(self.remove())
    }
    return crates.reversed()
  }
}

struct Instruction {
  let stackIndex: Int
  let numberOfCratesToMove: Int
  let targetStackIndex: Int

  func execute(crateStacks: inout [CrateStack], mode: OperationMode) {
    switch mode {
    case .Single:
      for _ in 0..<numberOfCratesToMove {
        let crate = crateStacks[stackIndex].remove()
        crateStacks[targetStackIndex].add(crate)
      }

    case .Multiple:
      let crates = crateStacks[stackIndex].remove(count: numberOfCratesToMove)
      crateStacks[targetStackIndex].add(allOf: crates)
    }
  }
}

extension Instruction {
  init(from instruction: Substring) {
    let searchRegex =
      /move (?<numberOfCratesToMove>\d+) from (?<stackIndex>\d+) to (?<targetStackIndex>\d+)/
    if let result = instruction.wholeMatch(of: searchRegex) {
      stackIndex = (Int(result.stackIndex) ?? 1) - 1
      numberOfCratesToMove = (Int(result.numberOfCratesToMove) ?? 0)
      targetStackIndex = (Int(result.targetStackIndex) ?? 1) - 1
    } else {
      self = Instruction(stackIndex: 0, numberOfCratesToMove: 0, targetStackIndex: 0)
    }
  }
}

enum OperationMode {
  case Single, Multiple
}

struct Dock: CustomStringConvertible {
  let instructions: [Instruction]
  var stacks: [CrateStack] = [CrateStack]()
  var operationMode: OperationMode = .Single

  init(from input: String) {
    let parts = input.split(separator: "\n\n")
    // get the number of stacks there are by the last row of data
    let rawStacks = parts[0].split(separator: "\n").reversed()

    // create the empty stacks from the first line that contains their number
    let numberOfStacks = rawStacks.first?.chunks(ofCount: 4).count ?? 0
    stacks.append(contentsOf: [CrateStack](repeating: CrateStack(), count: numberOfStacks))

    // parse the crate stack
    for line in rawStacks.dropFirst() {
      let crates = line.chunks(ofCount: 4).map {
        $0.trimmingCharacters(in: CharacterSet(charactersIn: "[] "))
      }
      for crate in crates.enumerated() {
        // if crate is empty, skip it, we need to keep it here, so there is no shift.
        // if we had removed it earlier we would not know there is nothing at this space
        if !crate.element.isEmpty {
          stacks[crate.offset].add(crate.element)
        }
      }
    }

    // parse the instructions
    instructions = parts[1].split(separator: "\n").map { Instruction(from: $0) }
  }

  mutating func operate() {
    for instruction in instructions {
      instruction.execute(crateStacks: &stacks, mode: operationMode)
    }
  }

  var topCrates: String {
    String(stacks.map { $0.topCrate }.joined(by: ""))
  }

  // make a nice display of the stacks for debugging
  var description: String {
    String(
      self.stacks.enumerated().map {
        "\($0 + 1) \($1)"
      }.joined(by: "\n"))
  }
}

struct Day05: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var dock: Dock {
    Dock(from: data)
  }

  func part1() -> String {
    var dock = dock
    dock.operate()
    return dock.topCrates
  }

  func part2() -> String {
    var dock = dock
    // change operation mode
    dock.operationMode = .Multiple
    dock.operate()
    return dock.topCrates
  }
}
