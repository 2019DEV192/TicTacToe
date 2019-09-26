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
    
    //MARK: check and update game status after each move
    
    private func updateGameModelWithNewActionAtLocation(_ position: Position, player: Player) {
        let newAction = GameActionModel(position: position, player: player)
        gameModel.actions.append(newAction)
        gameModel.currentPlayer = getPlayer(order: .next)
    }
    
    private func getNextPlayer() -> Player {
        switch gameModel.currentPlayer {
        case .player1:
            return .player2
        case .player2:
            return .player1
        }
    }
    
    private func updateGameStatusWithPosition(_ position:Position,
                                              player: Player) -> gameStatus
    {
        
        if let winningPositions = scanForTokensInLine(lineType: .horizontal, position: position, player: player) {
            //player won by creating a horizontal line
            return gameStatus(true, winningPositions, player)
        }
        
        if let winningPositions = scanForTokensInLine(lineType: .vertical, position: position, player: player) {
            //player won by creating a vertical line
            return gameStatus(true, winningPositions, player)
        }
        
        if let winningPositions = scanForTokensInDiagonal(diagonalType: .left, position: position, player: player) {
            //player won by creating a left diagonal
            return gameStatus(true, winningPositions, player)
        }
        
        if let winningPositions = scanForTokensInDiagonal(diagonalType: .right, position: position, player: player) {
            //player won by creating a right diagonal
            return gameStatus(true, winningPositions, player)
        }
        
        // if 9 moves, end game
        if self.gameModel.actions.count == 9 {
            return gameStatus(true, nil, nil)
        }
        //default don't end game
        return (gameOver: false, winningPositions: nil, player: nil)
    }
    
    //MARK: Diagonal lines related logic
    private func scanForTokensInDiagonal (diagonalType: DiagonalType,
                                          position: Position,
                                          player: Player) -> [Position]? {
        guard let diagonalPositions = generateViableDiagonalOnGridStarting(position, diagonalType: diagonalType) else {
            return nil
        }
        
        let possibleLine = gameModel.actions.filter { (actionModel) -> Bool in
            let containsPosition = diagonalPositions.contains(where: {$0 == actionModel.position})
    
            let playerOwnsAction = actionModel.player == player
            
            return containsPosition && playerOwnsAction
        }
        
        return possibleLine.count == self.getNumberOfItemsPerRow() ? diagonalPositions : nil
    }
    
    private func generateViableDiagonalOnGridStarting (_ position: Position, diagonalType: DiagonalType) -> [Position]? {
        
        switch diagonalType {
        case .left:
            return generateLeftDiagonalPositions(position)
        case .right:
            return generateRightDiagonalPositions(position)
        }
    }
    
    private func generateLeftDiagonalPositions (_ position: Position) -> [Position]? {
        
        var positionsOnDiagonal: [Position] = []
        //if diagonal starts in left corner, row == column
        //if the current position not on the left diagonal return
        if position.column != position.row {
            return nil
        }
        for i in 0..<gameModel.boardRowColumnSize {
            positionsOnDiagonal.append(Position(row: i, column: i))
        }
        
        return positionsOnDiagonal
    }
    
    private func generateRightDiagonalPositions (_ position: Position) -> [Position]? {
        
        var positionsOnDiagonal: [Position] = []
        //if diagonal starts in right corner
        for i in 0..<gameModel.boardRowColumnSize {
            positionsOnDiagonal.append(Position(row: i,
                                                column: gameModel.boardRowColumnSize - (i + 1)))
        }
        //if the current position is in this diagonal, proceed
        if positionsOnDiagonal.contains(where: {$0 == position}) {
            return positionsOnDiagonal
        } else {
            return nil
        }
    }
    
    //MARK: Horizontal and vertical lines related logic
    private func scanForTokensInLine (lineType: LineType,
                                      position: Position,
                                      player: Player) -> [Position]? {
        
        var possibleLine: [GameActionModel] = []
        
        switch lineType {
        case .horizontal:
            // take the elements on the same line
            possibleLine = gameModel.actions.filter({$0.position.row == position.row && $0.player == player})
        case .vertical:
            // take the elements on the same column
            possibleLine = gameModel.actions.filter({$0.position.column == position.column && $0.player == player})
        }
        
        if possibleLine.count == getNumberOfItemsPerRow() {
            let positions = possibleLine.map({ (actionModel) -> Position in
                return actionModel.position
            })
            //there is a winner
            return positions
        }
        //no winner
        return nil
    }
    
    
}

//MARK: implementation GameViewModel
extension GameViewModelImpl: GameViewModel {
    
    func checkPositionAvailable(_ position: Position) -> Bool {
        let containsPosition = self.gameModel.actions.contains(where: {$0.position == position})
        return !containsPosition
    }
    
    func reset() {
        self.gameModel.actions = []
        self.gameModel.currentPlayer = .player1
    }
    
    static func instantiate(boardSize: Int) -> GameViewModel {
        return GameViewModelImpl(boardSize: boardSize)
    }
    
    func getNumberOfItemsPerRow() -> Int {
        return gameModel.boardRowColumnSize
    }
    
    func getNumberOfGridItems() -> Int {
        return gameModel.boardRowColumnSize * gameModel.boardRowColumnSize
    }
    
    func endTurnWithMove(position: Position, player: Player, completion: feedbackClosure?) {
        self.updateGameModelWithNewActionAtLocation(position, player: player)
        let gameOverCheckResult = self.updateGameStatusWithPosition(position, player: player)
        completion?(gameOverCheckResult.gameOver, gameOverCheckResult.winningPositions, gameOverCheckResult.player)
    }
    
    public func getPlayer (order: PlayerOrder) -> Player {
        switch order {
        case .next:
            return getNextPlayer()
        case .current:
            return gameModel.currentPlayer
        }
    }
}
