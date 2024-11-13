import Testing

@testable import aoc

@Suite("Day03")
struct Day03Tests {
  let testData = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """

  @Test("Rucksack")
  func testRucksack() async throws {
    #expect(RuckSack(contents: "vJrwpWtwJgWrhcsFMMfFFhFp").duplicatedItem == "p")
    #expect(RuckSack(contents: "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL").duplicatedItem == "L")
    #expect(RuckSack(contents: "PmmdzqPrVvPwwTWBwg").duplicatedItem == "P")
  }

  @Test("Priority")
  func testPriority() async throws {
    #expect(getPriority("a") == 1)
    #expect(getPriority("A") == 27)
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day03(data: testData)
    #expect(challenge.part1() == 157)
  }

  @Test("Badge")
  func testBadge() async throws {
    #expect(
      GroupBadge(rucksacks: [
        "vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg",
      ]).badge == "r")
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day03(data: testData)
    #expect(challenge.part2() == 70)
  }
}
