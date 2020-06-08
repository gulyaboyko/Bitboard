//
//  BitboardTests.swift
//  BitboardTests
//
//  Created by Gulya Boiko on 6/1/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import XCTest
@testable import Bitboard
import AlgoTester

final class BitboardTests: XCTestCase {

    func test() {
        let sut = Tester(task: Bitboard(), bundleID: "com.gulya.boiko.Bitboard")
        sut.runTests(from: 30, to: 39)
    }

}
