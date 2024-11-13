import Algorithms

struct Section: Hashable, CustomStringConvertible {
  var start: Int
  var end: Int

  init(_ notation: Substring) {
    let values = notation.split(separator: "-")
    self.start = Int(values[0]) ?? 0
    self.end = Int(values[1]) ?? 0
  }

  func contains(other: Section) -> Bool {
    self.start <= other.start && self.end >= other.end
  }

  func overlap(other: Section) -> Bool {
    self.end >= other.start && self.start <= other.end
  }

  // custom display
  var description: String {
    "\(start)-\(end)"
  }
}

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var sections: [[Section]] {
    data.split(separator: "\n").map { line in
      line.split(separator: ",").map { Section($0) }
    }
  }

  // computes complete overlaps
  func isFullOverlap(_ pairs: [Section]) -> Bool {
    let a = pairs[0]
    let b = pairs[1]
    return a.contains(other: b) || b.contains(other: a)
  }

  // computes partial overlaps
  func isPartialOverlap(_ pairs: [Section]) -> Bool {
    let a = pairs[0]
    let b = pairs[1]
    return a.overlap(other: b) || b.overlap(other: a)
  }

  func part1() -> Int {
    return sections.filter(isFullOverlap).count
  }

  func part2() -> Int {
    return sections.filter(isPartialOverlap).count
  }
}
