import Testing

@testable import aoc

@Suite("Day06")
struct Day06Tests {

  @Test("part1")
  func testPart1() async throws {
    #expect(Day06(data: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part1() == 7)
    #expect(Day06(data: "bvwbjplbgvbhsrlpgdmjqwftvncz").part1() == 5)
    #expect(Day06(data: "nppdvjthqldpwncqszvftbrmjlhg").part1() == 6)
    #expect(Day06(data: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part1() == 10)
    #expect(Day06(data: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part1() == 11)
  }

  @Test("part2")
  func testPart2() async throws {
    #expect(Day06(data: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part2() == 19)
    #expect(Day06(data: "bvwbjplbgvbhsrlpgdmjqwftvncz").part2() == 23)
    #expect(Day06(data: "nppdvjthqldpwncqszvftbrmjlhg").part2() == 23)
    #expect(Day06(data: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part2() == 29)
    #expect(Day06(data: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part2() == 26)
  }
}
