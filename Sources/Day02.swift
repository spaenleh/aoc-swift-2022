import Algorithms

/// Protocol that allows conformance to moves
protocol Playable {
  var intoMove: Move { get }
}

/// Enum that allows to parse opponent moves
enum OpponentMove: String, Playable {
  case Rock = "A"
  case Paper = "B"
  case Scissors = "C"

  init<S: StringProtocol>(from move: S) {
    self = OpponentMove(rawValue: String(move)) ?? .Rock
  }

  var intoMove: Move {
    switch self {
    case .Rock: .Rock
    case .Paper: .Paper
    case .Scissors: .Scissors
    }
  }
}

/// Enum that allows to parse own moves
enum OwnMove: String, Playable {
  case Rock = "X"
  case Paper = "Y"
  case Scissors = "Z"

  init<S: StringProtocol>(from move: S) {
    self = OwnMove(rawValue: String(move)) ?? .Rock
  }

  var intoMove: Move {
    switch self {
    case .Rock: .Rock
    case .Paper: .Paper
    case .Scissors: .Scissors
    }
  }
}

/// Enum representing Outcomes of the game
enum Outcome: String {
  case Lose = "X"
  case Draw = "Y"
  case Win = "Z"
}

/// Represent a move in the Rock Paper, Scissors game
///
/// The enum has a raw value representing the score that the usage of a move gives you
enum Move: Int {
  // define the rawValue as the score user gets for playing the move
  case Rock = 1
  case Paper, Scissors

  static var allMoves: [Move] {
    [.Rock, .Paper, .Scissors]
  }

  static func shouldPlay(_ prediction: RoundPrediction) -> Self {
    switch prediction.outcome {
    case .Draw:
      return prediction.opponent
    case .Lose:
      return Move.allMoves.first { $0 < prediction.opponent } ?? .Rock
    case .Win:
      return Move.allMoves.first { $0 > prediction.opponent } ?? .Rock
    }
  }
}

/// Conform Move to Comparable so we can define an order and check for wins with <, >, ==
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
  var own: Move
  var opponent: Move

  func roundScore() -> Int {
    if own < opponent {
      return 0
    } else if own == opponent {
      return 3
    } else {
      return 6
    }
  }

  func totalScore() -> Int {
    roundScore() + own.rawValue
  }
}

// add overloaded initializer but keeping member-wise initializer
extension Round {
  init<S: StringProtocol>(from move: S) {
    let moves = move.split(separator: " ")
    opponent = OpponentMove(from: moves[0]).intoMove
    own = OwnMove(from: moves[1]).intoMove
  }
}

struct RoundPrediction {
  var opponent: Move
  var outcome: Outcome

  init<S: StringProtocol>(from prediction: S) {
    let moves = prediction.split(separator: " ")
    opponent = OpponentMove(from: moves[0]).intoMove
    outcome = Outcome(rawValue: String(moves[1])) ?? .Win
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
      score += Round(own: move, opponent: prediction.opponent).totalScore()
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
    strategyGuide.map { Round(from: $0) }
  }

  var definedOutcome: [RoundPrediction] {
    strategyGuide.map { RoundPrediction(from: $0) }
  }

  func part1() -> Int {
    Game.computeScore(forRounds: playSheet)
  }

  func part2() -> Int {
    Game.computeScore(forPrediction: definedOutcome)
  }
}
