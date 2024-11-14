import Testing

@testable import aoc

@Suite("Day05")
struct Day05Tests {
  let testData = """
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

  @Test("Parsing")
  func testParsing() async throws {
    let dock = Dock(from: testData)
    #expect(dock.stacks[0] == CrateStack(stack: ["Z", "N"]))
    #expect(dock.stacks[1] == CrateStack(stack: ["M", "C", "D"]))
    #expect(dock.stacks[2] == CrateStack(stack: ["P"]))
  }

  @Test("Instructions")
  func testInstructions() async throws {
    let instruction = Instruction(from: "move 1 from 2 to 1")
    #expect(instruction.numberOfCratesToMove == 1)
    #expect(instruction.stackIndex == 2)
    #expect(instruction.targetStackIndex == 1)
  }

  @Test("TopCrates")
  func testTopCrates() async throws {
    #expect(Dock(from: testData).topCrates == "NDP")
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day05(data: testData)
    #expect(challenge.part1() == "CMZ")
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day05(data: testData)
    #expect(challenge.part2() == "MCD")
  }
}
