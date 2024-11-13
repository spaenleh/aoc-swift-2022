import Testing

@testable import AdventOfCode

@Suite("Day01")
struct Day01Tests {
  let testData = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day01(data: testData)
    #expect(challenge.part1() == 24000)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day01(data: testData)
    #expect(challenge.part2() == 45000)
  }
}
