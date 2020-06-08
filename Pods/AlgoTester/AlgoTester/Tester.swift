//
//  Tester.swift
//  AlgoTester
//
//  Created by Gulya Boiko on 5/3/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation

public final class Tester {
    private let task: Testable
    private let bundleID: String
    
    public init(task: Testable, bundleID: String) {
        self.task = task
        self.bundleID = bundleID
    }
    
    public func runTests(from: Int, to: Int) {
        var nr = from
        while nr <= to {
            guard let inFile = Bundle.init(identifier: bundleID)?.path(forResource: "test.\(nr)", ofType: "in"), let outFile = Bundle.init(identifier: bundleID)?.path(forResource: "test.\(nr)", ofType: "out") else { return }
            print("Test #\(nr) = \(runTest(inFile: inFile, outFile: outFile))")
            nr += 1
        }
    }
    
    private func runTest(inFile: String, outFile: String) -> Bool {
        do {
            let inFileData = try String(contentsOfFile: inFile, encoding: .utf8)
            let inFileStrings = inFileData.components(separatedBy: .newlines)
            let extectedResult = try String(contentsOfFile: outFile, encoding: .utf8).components(separatedBy: .newlines).filter({ $0 != ""})
            let actualResult = task.run(data: inFileStrings)
            return actualResult == extectedResult
        } catch {
            return false
        }
    }
    
}
