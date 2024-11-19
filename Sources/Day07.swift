import Algorithms

struct File: CustomStringConvertible {
  var name: String
  var size: Int

  var description: String {
    "\(name) (file, size=\(size))"
  }
}

struct Johnny {

  var currentPath = [String]()
  var files: [String: File] = [String: File]()

  static func pathToString(path: [String]) -> String {
    (path).joined(separator: "/")
  }

  init(data: String) {
    // split the instructions
    let logLines = data.split(separator: "\n")

    // initialize the hierarchy

    // iterate over the instructions
    for line in logLines {
      print("\n---")
      // print(currentPath)

      // split the line into components
      let lineComponents = line.split(separator: " ")

      // detect commands
      if lineComponents[0] == "$" {
        let command = lineComponents[1]
        if command == "cd" {
          let argument = lineComponents[2]
          if argument == ".." {
            // going up
            let _ = currentPath.popLast() ?? "not found"
          } else if argument == "/" {
            // at the start
            currentPath = ["/"]
          } else {
            // we used something like "cd a"
            print("adding \(argument) to path")
            currentPath.append(String(argument))
          }
        }
        if command == "ls" {
          print("path", currentPath)
          print("current dir is \(currentPath.last ?? "not found")")
        }
      } else {
        if lineComponents[0] == "dir" {
          let dirName = String(lineComponents[1])
          print("there will be a dir called: \(dirName)")
        } else {
          // treating files
          let name = String(lineComponents[1])
          let size = Int(lineComponents[0]) ?? 0
          let path = Self.pathToString(path: currentPath)
          print("file \(name), \(size)")
          files[path] = File(name: name, size: size)
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
    let walker = Johnny(data: data)
    print(walker.files)
    // return walker.allDirectorySizes.filter { $0 <= 100_000 }.reduce(0, +)
    return 0
  }

  func part2() -> Int {
    0
  }
}
