import Testing

@testable import aoc

@Suite("Day04")
struct Day04Tests {
  let testData = """
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day04(data: testData)
    #expect(challenge.part1() == 2)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day04(data: testData)
    #expect(challenge.part2() == 4)
  }

  @Test("Overlaps")
  func testOverlap() async throws {
    let challenge = Day04(
      data: """
        1-3,4-6
        4-6,1-3
        """)
    #expect(challenge.part2() == 0)
  }
}
