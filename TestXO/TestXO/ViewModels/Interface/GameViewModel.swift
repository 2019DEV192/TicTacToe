//
//  GameViewModel.swift
//  TestXO

import Foundation

protocol GameViewModel {
    
    typealias feedbackClosure = (_ gameCompleted: Bool, _ winningMoves: [Position]?, _ winningPlayer: Player?) -> ()
    
    /// Returns: total number of grid items
    ///
    /// - Returns: total number of grid items
    func getNumberOfGridItems () -> Int
    
    /// Returns: number of grid items per row
    ///
    /// - Returns: number of grid items per row
    func getNumberOfItemsPerRow () -> Int
    
    /// ends player turn after action
    ///
    /// - Parameters:
    ///   - position: the position in the grid for the new action
    ///   - player: the player doing the action
    ///   - completion: callback after the action has been evaluated
    /// - Returns: void
    func endTurnWithMove (position: Position, player: Player, completion: feedbackClosure?)
    
    /// gets player data
    ///
    /// - Parameter order: can be previous player, current player or next player
    /// - Returns: the player
    func getPlayer (order: PlayerOrder) -> Player
    
    /// resets game
    func reset ()
    
    static func instantiate (boardSize: Int) -> GameViewModel
}
