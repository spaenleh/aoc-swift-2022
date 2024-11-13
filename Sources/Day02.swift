import Algorithms

enum Move: Int {
  case Rock = 1
  case Paper, Scissors

  static var allMoves: [Move] {
    [.Rock, .Paper, .Scissors]
  }

  enum ParseError: Error {
    case InvalidMove
  }

  static func parseOwn<S: StringProtocol>(_ move: S) throws -> Self {
    switch move {
    case "X":
      return .Rock
    case "Y":
      return .Paper
    case "Z":
      return .Scissors
    default:
      throw ParseError.InvalidMove

    }
  }

  static func parseOpponent<S: StringProtocol>(_ move: S) throws -> Self {
    switch move {
    case "A":
      return .Rock
    case "B":
      return .Paper
    case "C":
      return .Scissors
    default:
      throw ParseError.InvalidMove
    }
  }

  static func shouldPlay(_ prediction: RoundPrediction) -> Self {
    switch prediction.outcome {
    case .Draw:
      return prediction.opponentMove
    case .Lose:
      return Move.allMoves.first { $0 < prediction.opponentMove }!
    case .Win:
      return Move.allMoves.first { $0 > prediction.opponentMove }!
    }
  }
}

enum Outcome: String {
  case Lose = "X"
  case Draw = "Y"
  case Win = "Z"
}

extension Move: Comparable {
  static func < (lhs: Move, rhs: Move) -> Bool {
    switch lhs {
    case .Rock: return rhs == .Paper
    case .Paper: return rhs == .Scissors
    case .Scissors: return rhs == .Rock
    }
  }
}

struct Round {
  var ownMove: Move
  var opponentMove: Move

  static func parse<S: StringProtocol>(from move: S) -> Self {
    let moves = move.split(separator: " ")
    let (opponent, own) = (moves[0], moves[1])
    return Round(ownMove: try! Move.parseOwn(own), opponentMove: try! Move.parseOpponent(opponent))
  }

  func roundScore() -> Int {
    if ownMove < opponentMove {
      return 0
    } else if ownMove == opponentMove {
      return 3
    } else {
      return 6
    }
  }

  func totalScore() -> Int {
    roundScore() + ownMove.rawValue
  }
}

struct RoundPrediction {
  var opponentMove: Move
  var outcome: Outcome

  static func parse<S: StringProtocol>(from prediction: S) -> Self {
    let moves = prediction.split(separator: " ")
    return Self(
      opponentMove: try! Move.parseOpponent(moves[0]), outcome: Outcome(rawValue: String(moves[1]))!
    )
  }
}

struct Game {

  static func computeScore(forRounds rounds: [Round]) -> Int {
    var score = 0
    for round in rounds {
      score += round.totalScore()
    }
    return score
  }

  static func computeScore(forPrediction predictions: [RoundPrediction]) -> Int {
    var score = 0
    for prediction in predictions {
      let move = Move.shouldPlay(prediction)
      score += Round(ownMove: move, opponentMove: prediction.opponentMove).totalScore()
    }
    return score
  }
}

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var strategyGuide: [Substring] {
    data.split(separator: "\n")
  }

  var playSheet: [Round] {
    strategyGuide.map { Round.parse(from: $0) }
  }

  var definedOutcome: [RoundPrediction] {
    strategyGuide.map { RoundPrediction.parse(from: $0) }
  }

  func part1() -> Int {
    Game.computeScore(forRounds: playSheet)
  }

  func part2() -> Int {
    Game.computeScore(forPrediction: definedOutcome)
  }
}
