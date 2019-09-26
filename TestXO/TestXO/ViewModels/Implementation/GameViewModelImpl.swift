//
//  GameViewModelImpl.swift
//  TestXO


import Foundation

class GameViewModelImpl {
    
    //MARK: Private variables
    private var gameModel: GameModel
    
    //MARK: Type definitions
    private enum LineType {
        case horizontal
        case vertical
    }
    private enum DiagonalType {
        case left
        case right
    }
    
    private typealias gameStatus = (gameOver: Bool, winningPositions: [Position]?, player: Player?)
    
    
    //MARK: init methods
    init(boardSize: Int) {
        self.gameModel = GameModel(boardRowColumnSize: boardSize,
                                   actions: [],
                                   currentPlayer: .player1)
    }
    
    
}

//MARK: implementation GameViewModel
extension GameViewModelImpl: GameViewModel {
    func getNumberOfGridItems() -> Int {
        return 0
    }
    
    func getNumberOfItemsPerRow() -> Int {
        return 0
    }
    
    func endTurnWithMove(position: Position, player: Player, completion: feedbackClosure?) {
        completion?(false, [], Player.player1)
    }
    
    func getPlayer(order: PlayerOrder) -> Player {
        return Player.player1
    }
    
    func reset() {
        
    }
    
    static func instantiate(boardSize: Int) -> GameViewModel {
        return GameViewModelImpl(boardSize: boardSize)
    }
    
    
}
