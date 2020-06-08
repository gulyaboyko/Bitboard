//
//  Bitboard.swift
//  Bitboard-King
//
//  Created by Gulya Boiko on 6/1/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation
import AlgoTester

final class Bitboard {
    let leftEmptyRows: [UInt] = [0xfefefefefefefefe, 0xfcfcfcfcfcfcfcfc, 0xf8f8f8f8f8f8f8f8, 0xf0f0f0f0f0f0f0f0, 0xe0e0e0e0e0e0e0e0, 0xc0c0c0c0c0c0c0c0, 0x8080808080808080]
    let rightEmptyRows: [UInt] = [0x7f7f7f7f7f7f7f7f, 0x3f3f3f3f3f3f3f3f, 0x1f1f1f1f1f1f1f1f, 0xf0f0f0f0f0f0f0f, 0x707070707070707, 0x303030303030303, 0x101010101010101]

    func findKingMoves(indexCell: UInt) -> (count: UInt, movesMask: UInt) {
        let k: UInt = 1 << indexCell // King is here
        let lk = k & leftEmptyRows[0]
        let rk = k & rightEmptyRows[0]
        let mask = lk << 7 | k << 8 | rk << 9 |
                   lk >> 1 |          rk << 1 |
                   lk >> 9 | k >> 8 | rk >> 7
        return (countBits(mask: mask), mask)
    }

    func findKnightMoves(indexCell: UInt) -> (count: UInt, movesMask: UInt) {
        let k: UInt = 1 << indexCell // Knight is here
        let lk1 = k & leftEmptyRows[0]
        let lk2 = k & leftEmptyRows[1]
        let rk1 = k & rightEmptyRows[0]
        let rk2 = k & rightEmptyRows[1]
        let mask = lk2 << 6  | lk1 << 15 | rk1 << 17 | rk2 << 10 |
                   lk2 >> 10 | lk1 >> 17 | rk1 >> 15 | rk2 >> 6
        return (countBits(mask: mask), mask)
    }
    
    func findRookMoves(fen: String) -> UInt {
        let array = convertToPiece(from: fen)
        let opponentPlaces = array[6] | array[7] | array[8] | array[9] | array[10] | array[11]
        let cooperatorPlaces = array[0] | array[1] | array[2] | array[4] | array[5]
        return findRookMoves(place: array[3], opponentPlaces: opponentPlaces, cooperatorPlaces: cooperatorPlaces)
    }
    
    func findBishopMoves(fen: String) -> UInt {
        let array = convertToPiece(from: fen)
        let opponentPlaces = array[6] | array[7] | array[8] | array[9] | array[10] | array[11]
        let cooperatorPlaces = array[0] | array[1] | array[3] | array[4] | array[5]
        return findBishopMoves(place: array[2], opponentPlaces: opponentPlaces, cooperatorPlaces: cooperatorPlaces)
    }
    
    func findQueenMoves(fen: String) -> UInt {
        let array = convertToPiece(from: fen)
        let opponentPlaces = array[6] | array[7] | array[8] | array[9] | array[10] | array[11]
        let cooperatorPlaces = array[0] | array[1] | array[2] | array[3] | array[5]
        return findQueenMoves(place: array[4], opponentPlaces: opponentPlaces, cooperatorPlaces: cooperatorPlaces)
    }
    
    private func findRookMoves(place: UInt, opponentPlaces: UInt, cooperatorPlaces: UInt) -> UInt {
        var mask: UInt = 0
        let upDownMoves: [UInt] = [8, 16, 24, 32, 40, 48, 56]
        let leftRightMoves: [UInt] = [1, 2, 3, 4, 5, 6, 7]
        for number in upDownMoves {
            let move = place >> number // down
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for number in upDownMoves {
            let move = place << number // up
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in leftRightMoves.enumerated() {
            let lr = place & leftEmptyRows[i]
            let move = lr >> value // left
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in leftRightMoves.enumerated() {
            let rr = place & rightEmptyRows[i]
            let move = rr << value // right
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        return mask
    }
    
    private func findBishopMoves(place: UInt, opponentPlaces: UInt, cooperatorPlaces: UInt) -> UInt {
        var mask: UInt = 0
        let diagonal1Moves: [UInt] = [7, 14, 21, 28, 35, 42, 49]
        let diagonal2Moves: [UInt] = [9, 18, 27, 36, 45, 54, 63]
        for (i, value) in diagonal1Moves.enumerated() { // up Left
            let bLeftUP = place & leftEmptyRows[i]
            let move = bLeftUP << value
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in diagonal1Moves.enumerated() { // down Right
            let bRightDOWN = place & rightEmptyRows[i]
            let move = bRightDOWN >> value
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in diagonal2Moves.enumerated() { // down Left
            let bLeftDown = place & leftEmptyRows[i]
            let move = bLeftDown >> value
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in diagonal2Moves.enumerated() { // up Right
            let bRightUP = place & rightEmptyRows[i]
            let move = bRightUP << value
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        return mask
    }
    
    private func findQueenMoves(place: UInt, opponentPlaces: UInt, cooperatorPlaces: UInt) -> UInt {
        return findRookMoves(place: place, opponentPlaces: opponentPlaces, cooperatorPlaces: cooperatorPlaces) | findBishopMoves(place: place, opponentPlaces: opponentPlaces, cooperatorPlaces: cooperatorPlaces)
    }

    private func countBits(mask: UInt) -> UInt {
        var mask = mask
        var countMoves: UInt = 0
        while mask > 0 {
            mask = mask & (mask - 1)
            countMoves += 1
        }
        return countMoves
    }
}

extension Bitboard: Testable {
    func run(data: [String]) -> [String] {
        let result1 = findBishopMoves(fen: data[0])
        let result2 = findRookMoves(fen: data[0])
        let result3 = findQueenMoves(fen: data[0])
        return [String(result2), String(result1), String(result3)]
    }
}
