//
//  Position.swift
//  TestXO


import Foundation
struct Position {
    let row: Int
    let column: Int
}

extension Position: Equatable {
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.row == rhs.row &&
            lhs.column == rhs.column
    }
    
}
