import Algorithms

protocol Storageable {
  var size: Int { get }
  var sizes: [Int] { get }
}

struct File: Storageable, CustomStringConvertible {
  var name: String
  var size: Int
  var sizes: [Int] {
    [size]
  }
  var description: String {
    "\(name) (file, size=\(size))"
  }
}

final class Directory: Storageable, CustomStringConvertible {
  var name: String
  var dirs: [Directory] = [Directory]()
  var files: [File] = [File]()
  var contents: [Storageable] {
    var c = [Storageable]()
    c.append(contentsOf: dirs)
    c.append(contentsOf: files)
    return c
  }

  var size: Int {
    contents.map { $0.size }.reduce(0, +)
  }

  var sizes: [Int] {
    dirs.map { dir in
      print(dir.name)
      return dir.sizes
    }.flatMap { $0 }
  }

  init(name: String) {
    self.name = name
  }

  var description: String {
    var text = ""
    text += "\(name) (dir)\n"
    text += "\(files.map { "\($0)" }.joined(separator: "\n"))\n"
    for dir in dirs {
      text += "\(dir.files.map { "\($0)" }.joined(separator: "\n- "))\n"
    }

    return text
  }
}

struct Walker {

  var currentPath = [String]()
  var fileHierarchy: Directory

  init(log: String) {
    // split the instructions
    let logLines = log.split(separator: "\n")

    // initialize the hierarchy
    fileHierarchy = Directory(name: "/")
    // this is the var that will follow the currently open dir
    var currentDir: Directory = fileHierarchy

    // iterate over the instructions
    for line in logLines {
      print("\n---")
      print(currentPath)
      print(fileHierarchy)

      // split the line into components
      let lineComponents = line.split(separator: " ")
      print("components", lineComponents)

      // detect commands
      if lineComponents[0] == "$" {
        let command = lineComponents[1]
        if command == "cd" {
          let argument = lineComponents[2]
          if argument == ".." {
            // going up
            let current = currentPath.popLast() ?? "not found"
            print("leaving \(current)")
            currentDir = fileHierarchy
            for comp in currentPath[1...] {
              currentDir = currentDir.dirs.first { dir in
                dir.name == comp
              }!
            }
          } else if argument == "/" {
            // at the start
            currentPath = ["/"]
          } else {
            // currentPath.append(String(argument))
            // currentDir = fileHierarchy
            // for comp in currentPath {
            //   currentDir = currentDir.dirs.first { dir in
            //     dir.name == comp
            //   }!
            // }
            // print(currentDir.name)
            // print("nav", currentDir.dirs)
            // currentDir.
            print("adding \(argument) to path")
            currentPath.append(String(argument))
          }
        }
        if command == "ls" {
          currentDir = fileHierarchy
          print("path", currentPath)
          for comp in currentPath[1...] {
            currentDir = currentDir.dirs.first { dir in
              dir.name == comp
            }!
          }
          print("current dir is \(currentDir.name)")
        }
      } else {
        if lineComponents[0] == "dir" {
          let dirName = String(lineComponents[1])
          print("dirname", dirName)
          currentDir.dirs.append(Directory(name: dirName))
          print(fileHierarchy)
          print(currentDir.dirs)
        } else {
          let name = String(lineComponents[1])
          let size = Int(lineComponents[0]) ?? 0
          currentDir.files.append(File(name: name, size: size))
        }
      }
    }
    print("final:", fileHierarchy)
  }

  var allDirectorySizes: [Int] {
    fileHierarchy.sizes
  }
}

struct Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // add here any computed values useful for the challenge

  func part1() -> Int {
    let walker = Walker(log: data)
    print(walker.allDirectorySizes)
    return walker.allDirectorySizes.filter { $0 <= 100_000 }.reduce(0, +)
  }

  func part2() -> Int {
    0
  }
}
