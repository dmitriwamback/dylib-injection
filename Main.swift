import Foundation
import Cocoa

class Injector {

    var pipe: Pipe!

    func compileToDynamicLibrary() {

    }

    func createProcess(command: [String]) -> Process {
        pipe = Pipe()

        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/bin/bash")
        task.standardOutput = pipe
        task.standardError  = pipe
        task.standardInput  = nil
        task.arguments = command
        return task
    }


    func runTask(process: Process) -> String {

        var output = ""
        do {
            try process.run()
            output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)!
        }
        catch { return error.localizedDescription }

        return output
    }


    func startWithInjection() -> String {
        
        let basicCommand = ["-c", "DYLD_INSERT_LIBRARIES=calculator.dylib ./a.out"]

        return runTask(process: createProcess(command: basicCommand))
    }

    func start() -> String {
        let command = ["-c", "./a.out"]
        return runTask(process: createProcess(command: command))
    }
}
let main = Injector()
print(main.startWithInjection())