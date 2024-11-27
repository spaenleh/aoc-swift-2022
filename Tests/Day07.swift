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


  @Test("Create structure")
  func testStructureCreation() async throws {
    let structure = Johnny(data: testData)
    #expect(structure.files.count == 10)
    #expect(structure.totalSize() == 48_381_165)
    let sizes = structure.sizeByFolder()
    #expect(sizes[""] == 48_381_165)
    #expect(sizes["a/e"] == 584)
    #expect(sizes["a"] == 94853)
    #expect(sizes["d"] == 24_933_642)
  }

  @Test("Loops")
  func testLoops() async throws {
    let testDataWithLoops = """
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
      $ cd ..
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ cd e
      $ ls
      584 i
      $ cd ..
      """
    let challenge = Day07(data: testDataWithLoops)
    #expect(challenge.part1() == 95437)
  }

  @Test("Intricate Dirs")
  func testComplexStructure() async throws {
    let testDataComplex = """
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      dir k
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd k
      $ ls
      12345 kk.zip
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
      """
    let structure = Johnny(data: testDataComplex)
    #expect(structure.files.count == 11)
    #expect(structure.totalSize() == 48_393_510)
    let sizes = structure.sizeByFolder()
    #expect(sizes[""] == 48_393_510)
    #expect(sizes["a/e"] == 584)
    #expect(sizes["a/k"] == 12345)
    #expect(sizes["a"] == 107_198)
    #expect(sizes["d"] == 24_933_642)
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
