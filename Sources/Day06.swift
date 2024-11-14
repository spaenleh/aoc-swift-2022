import Algorithms

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func detectStartOfMessage(windowSize: Int) -> Int {
    let messageLength = data.count
    let message = Array(data)
    for idx in 0..<(messageLength - windowSize) {
      let sub = message[idx..<(idx + windowSize)]
      if Set(sub).count == windowSize {
        return idx + windowSize
      }
    }
    return message.count
  }

  func part1() -> Int {
    detectStartOfMessage(windowSize: 4)
  }

  func part2() -> Int {
    detectStartOfMessage(windowSize: 14)
  }
}
