import Testing

@testable import AdventOfCode

@Suite("Day00")
struct Day00Tests {
  let testData = """

    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day00(data: testData)
    #expect(challenge.part1() == 0)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day00(data: testData)
    #expect(challenge.part1() == 0)
  }
}
