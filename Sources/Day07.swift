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

  static func pathToString(path: [String], name: String) -> String {
    "\((path).joined(separator: "/"))/\(name)"
  }

  init(data: String) {
    // split the instructions
    let logLines = data.split(separator: "\n")

    // iterate over the instructions
    for line in logLines {

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
            currentPath = []
          } else {
            // we used something like "cd a"
            // print("adding \(argument) to path")
            currentPath.append(String(argument))
          }
        }
        if command == "ls" {
          continue
        }
      } else {
        if lineComponents[0] != "dir" {
          // treating files
          let name = String(lineComponents[1])
          let size = Int(lineComponents[0]) ?? 0
          let path = Self.pathToString(path: currentPath, name: name)
          // print("file \(name), \(size)")
          files[path] = File(name: name, size: size)
        }
      }
    }
  }

  func totalSize() -> Int {
    files.values.map { $0.size }.reduce(0, +)
  }

  func sizeByFolder() -> [String: Int] {
    var folderSizes = [String: Int]()

    let dirs = files.grouped { (key: String, value: File) in
      let keys = key.split(separator: "/")
      return keys[..<(keys.count - 1)].joined(separator: "/")
    }
    for (key, _) in dirs {
      let containedDirs = dirs.filter { $0.key.hasPrefix(key) }
      let containedSizes = containedDirs.values.map { v in
        v.map { $1.size }.reduce(0, +)
      }
      folderSizes[key] = containedSizes.reduce(0, +)
    }
    return folderSizes
  }
}

struct Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // add here any computed values useful for the challenge

  func part1() -> Int {
    let walker = Johnny(data: data)
    // 1221521 -> too low
    // 2242716 -> too high
    // 34589339 -> too high
    let smallDirs = walker.sizeByFolder().filter { $1 < 100_000 }
    for dir in smallDirs {
      print(dir)
    }
    return smallDirs.map { $1 }.reduce(0, +)
  }

  func part2() -> Int {
    0
  }
}
