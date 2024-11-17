import Algorithms

protocol Storageable {
  var size: Int { get }
}

struct File: Storageable {
  var name: String
  var size: Int
}

struct Directory: Storageable {
  var name: String
  var dirs: [String: Directory] = [String: Directory]()
  var files: [String: File] = [String: File]()
  var contents: [Storageable] {
    var c = [Storageable]()
    c.append(contentsOf: Array(dirs.values))
    c.append(contentsOf: Array(files.values))
    return c
  }

  var size: Int {
    contents.map { $0.size }.reduce(0, +)
  }

}

struct Walker {

  var currentPath = [String]()
  var fileHierarchy: Directory

  mutating func parse(log: String) {
    let logLines = log.split(separator: "\n")
    var currentDir: Directory = Directory(name: "/")
    for line in logLines {
      let lineComponents = line.split(separator: " ")

      // detect commands
      if lineComponents[0] == "$" {
        let command = lineComponents[1]
        if command == "cd" {
          let argument = lineComponents[3]
          if argument == ".." {
            // going up
            currentPath.popLast()
          } else if argument == "/" {
            // at the start
            fileHierarchy = Directory(name: "/")
          } else {
            for comp in currentPath {
              currentDir = currentDir.dirs[comp]!
            }
            print(currentDir.name)
            // currentDir.
            currentPath.append(String(argument))
          }
        }
        if command == "ls" {

        }
      } else {
        if lineComponents[0] == "dir" {
          let dirName = String(lineComponents[1])
          currentDir.dirs[dirName] = Directory(name: dirName)
        }
      }
    }
  }
}

struct Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // add here any computed values useful for the challenge

  func part1() -> Int {
    0
  }

  func part2() -> Int {
    0
  }
}
