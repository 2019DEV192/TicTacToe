//
//  GameModel.swift
//  TestXO

import Foundation

struct GameModel {
    
    let boardRowColumnSize: Int
    var actions: [GameActionModel]
    var currentPlayer: Player
    
}
