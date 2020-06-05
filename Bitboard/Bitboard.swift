//
//  Bitboard.swift
//  Bitboard-King
//
//  Created by Gulya Boiko on 6/1/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation

final class Bitboard {
    let leftEmptyRow: [UInt] = [0xfefefefefefefefe, 0xfcfcfcfcfcfcfcfc, 0xf8f8f8f8f8f8f8f8, 0xf0f0f0f0f0f0f0f0, 0xe0e0e0e0e0e0e0e0, 0xc0c0c0c0c0c0c0c0, 0x8080808080808080]
    let rightEmptyRow: [UInt] = [0x7f7f7f7f7f7f7f7f, 0x3f3f3f3f3f3f3f3f, 0x1f1f1f1f1f1f1f1f, 0xf0f0f0f0f0f0f0f, 0x707070707070707, 0x303030303030303, 0x101010101010101]

    func findKingMoves(indexCell: UInt) -> (count: UInt, movesMask: UInt) {
        let k: UInt = 1 << indexCell // King is here
        let lk = k & leftEmptyRow[0]
        let rk = k & rightEmptyRow[0]
        let mask = lk << 7 | k << 8 | rk << 9 |
                   lk >> 1 |          rk << 1 |
                   lk >> 9 | k >> 8 | rk >> 7
        return (countOneBits(mask: mask), mask)
    }

    func findKnightMoves(indexCell: UInt) -> (count: UInt, movesMask: UInt) {
        let k: UInt = 1 << indexCell // Knight is here
        let lk1 = k & leftEmptyRow[0]
        let lk2 = k & leftEmptyRow[1]
        let rk1 = k & rightEmptyRow[0]
        let rk2 = k & rightEmptyRow[1]
        let mask = lk2 << 6  | lk1 << 15 | rk1 << 17 | rk2 << 10 |
                   lk2 >> 10 | lk1 >> 17 | rk1 >> 15 | rk2 >> 6
        return (countOneBits(mask: mask), mask)
    }
    
    func findRookMoves(place: UInt, opponentPlaces: UInt, cooperatorPlaces: UInt) -> UInt {
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
            let lr = place & leftEmptyRow[i]
            let move = lr >> value // left
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in leftRightMoves.enumerated() {
            let rr = place & rightEmptyRow[i]
            let move = rr << value // right
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        return mask
    }
    
    func findBishopMoves(place: UInt, opponentPlaces: UInt, cooperatorPlaces: UInt) -> UInt {
        var mask: UInt = 0
        let diagonal1Moves: [UInt] = [7, 14, 21, 28, 35, 42, 49]
        let diagonal2Moves: [UInt] = [9, 18, 27, 36, 45, 54, 63]
        for (i, value) in diagonal1Moves.enumerated() {
            let bLeftUP = place & leftEmptyRow[i]
            let move = bLeftUP << value
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in diagonal1Moves.enumerated() {
            let bRightDOWN = place & rightEmptyRow[i]
            let move = bRightDOWN >> value
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in diagonal2Moves.enumerated() {
            let bLeftDown = place & leftEmptyRow[i]
            let move = bLeftDown >> value
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        for (i, value) in diagonal2Moves.enumerated() {
            let bRightUP = place & rightEmptyRow[i]
            let move = bRightUP << value
            if (cooperatorPlaces & move) != 0 { break }
            mask = mask | move
            if (opponentPlaces & move) != 0 { break }
        }
        return mask
    }
    
//    func findBishopMoves(index: UInt) -> UInt {
//        let bPlace: UInt = 1 << index // Bishop is here
//        return findBishopMoves(place: bPlace)
//    }
    
//    func findQueenMoves(place: UInt) -> UInt {
//        return findRookMoves(place: place) | findBishopMoves(place: place)
//    }
//
//    func findQueenMoves(index: UInt) -> UInt {
//        return findRookMoves(index: index) | findBishopMoves(index: index)
//    }
    
    private func countOneBits(mask: UInt) -> UInt {
        var mask = mask
        var countMoves: UInt = 0
        while mask > 0 {
            mask = mask & (mask - 1)
            countMoves += 1
        }
        return countMoves
    }
}
