//
//  BitboardTests.swift
//  BitboardTests
//
//  Created by Gulya Boiko on 6/1/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import XCTest
@testable import Bitboard

final class BitboardTests: XCTestCase {

    func test() {
        let sut = Bitboard()
        
        print(sut.findBishopMoves(place: 137438953472, opponentPlaces: 10273871076796416, cooperatorPlaces: 2326721290568704))
    }

}

//        print(sut.findQueenMoves(cell: 0))
//        print(sut.findQueenMoves(cell: 1))
//        print(sut.findQueenMoves(cell: 35))
//        print(sut.findQueenMoves(cell: 32))
//        print(sut.findQueenMoves(cell: 39))
//        print(sut.findQueenMoves(cell: 56))
//        print(sut.findQueenMoves(cell: 63))
