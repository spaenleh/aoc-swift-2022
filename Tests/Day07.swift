import Testing

@testable import aoc

@Suite("Day07")
struct Day07Tests {
  let testData = """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """

  @Test("Walker")
  func testWalker() async throws {
    var walk = Johnny(
      data:
        """
        $ cd /
        $ ls
        dir a
        1234 b.txt
        """)
    // #expect(walk.files.dirs[0].name == "a")
    // let fileValues = walk.fileHierarchy.files
    // #expect(fileValues[0].name == "b.txt")
    // #expect(fileValues[0].size == 1234)
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day07(data: testData)
    #expect(challenge.part1() == 95437)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day07(data: testData)
    #expect(challenge.part2() == 0)
  }
}
