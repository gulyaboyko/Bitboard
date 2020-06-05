//
//  Bitboard+FEN.swift
//  Bitboard-King
//
//  Created by Gulya Boiko on 6/1/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation

// FEN
extension Bitboard {
    private enum Piece: Character {
    case whitePawns = "P"
    case whiteKnights = "N"
    case whiteBishops = "B"
    case whiteRooks = "R"
    case whiteQueens = "Q"
    case whiteKing = "K"
    case blackPawns = "p"
    case blackKnights = "n"
    case blackBishops = "b"
    case blackRooks = "r"
    case blackQueens = "q"
    case blackKing = "k"
    }
    func convertToPiece(from fen: String) -> [UInt] {
        var result: [UInt] = Array.init(repeating: 0, count: 12)
        var index = 0
        let str = fen.components(separatedBy: "/").reversed().joined()
        for char in str {
            if char.isNumber { index = index + (Int(String(char)) ?? 0); continue }
            let x: UInt = 1 << index
            switch char {
            case Piece.whitePawns.rawValue:
                result[0] = result[0] | x
            case Piece.whiteKnights.rawValue:
                result[1] = result[1] | x
            case Piece.whiteBishops.rawValue:
                result[2] = result[2] | x
            case Piece.whiteRooks.rawValue:
                result[3] = result[3] | x
            case Piece.whiteQueens.rawValue:
                result[4] = result[4] | x
            case Piece.whiteKing.rawValue:
                result[5] = result[5] | x
            case Piece.blackPawns.rawValue:
                result[6] = result[6] | x
            case Piece.blackKnights.rawValue:
                result[7] = result[7] | x
            case Piece.blackBishops.rawValue:
                result[8] = result[8] | x
            case Piece.blackRooks.rawValue:
                result[9] = result[9] | x
            case Piece.blackQueens.rawValue:
                result[10] = result[10] | x
            case Piece.blackKing.rawValue:
                result[11] = result[11] | x
            default: break
            }
            index += 1
        }
        return result
    }
}
