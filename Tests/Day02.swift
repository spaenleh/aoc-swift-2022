import Testing

@testable import aoc

@Suite("Day02")
struct Day02Tests {
  let testData = """
    A Y
    B X
    C Z
    """

  @Test("Comparisons of moves")
  func testComparisons() async throws {
    #expect(Move.Paper > Move.Rock, "Paper beats rock")
    #expect(Move.Rock > Move.Scissors, "Rock beats scissors")
    #expect(Move.Scissors > Move.Paper, "Scissors beats paper")
  }

  @Test("Scoring")
  func testSCoring() async throws {
    #expect(Round(own: .Paper, opponent: .Paper).roundScore() == 3, "Draw scores 3 points")
    #expect(Round(own: .Paper, opponent: .Rock).roundScore() == 6, "Win scores 6 points")
    #expect(Round(own: .Rock, opponent: .Paper).roundScore() == 0, "Lose scores 0 points")
  }

  @Test("Single round")
  func testSingleRound() async throws {
    #expect(Game.computeScore(forRounds: [Round(from: "A Y")]) == 8, "Draw")
  }

  @Test("part1")
  func testPart1() async throws {
    let challenge = Day02(data: testData)
    #expect(challenge.part1() == 15)
  }

  @Test("With Predictions")
  func testPrediction() async throws {
    #expect(Move.shouldPlay(RoundPrediction(from: "A Y")) == .Rock)
  }

  @Test("part2")
  func testPart2() async throws {
    let challenge = Day02(data: testData)
    #expect(challenge.part2() == 12)
  }
}
