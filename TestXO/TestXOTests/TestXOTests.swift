//
//  TestXOTests.swift
//  TestXOTests
//
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import TestXO

class TestXOTests: XCTestCase {

    var gameModel3Lines: GameViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameModel3Lines = GameViewModelImpl(boardSize: 3)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameModel3Lines = nil
    }
    
    func testCurrentPlayerAtBeginning() {
        let currentPlayer = gameModel3Lines.getPlayer(order: .current)
        XCTAssertEqual(currentPlayer, Player.player1)
    }
    
    func testNextPlayerAtBeginning() {
        let nextPlayer = gameModel3Lines.getPlayer(order: .next)
        XCTAssertEqual(nextPlayer, Player.player2)
    }
    
    
    func testWinnerInHorizontalLine(){
        let p1 = Position(row: 1, column: 1)
        let p2 = Position(row: 2, column: 1)
        let p3 = Position(row: 0, column: 1)
        gameModel3Lines.endTurnWithMove(position: p1, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p2, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p3, player: Player.player1, completion: { (gameOver, winningPositions, winnerPlayer) in
            
            XCTAssertEqual(winnerPlayer, Player.player1)
            XCTAssertTrue(gameOver)
            XCTAssertNotNil(winningPositions)
        })
    }
    
    func testWinnerInVerticalLine(){
        let p1 = Position(row: 1, column: 1)
        let p2 = Position(row: 1, column: 2)
        let p3 = Position(row: 1, column: 0)
        gameModel3Lines.endTurnWithMove(position: p1, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p2, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p3, player: Player.player1, completion: { (gameOver, winningPositions, winnerPlayer) in
            
            XCTAssertEqual(winnerPlayer, Player.player1)
            XCTAssertTrue(gameOver)
            XCTAssertNotNil(winningPositions)
        })
    }
    
    func testWinnerInLeftDiagonal(){
        let p1 = Position(row: 0, column: 0)
        let p2 = Position(row: 1, column: 1)
        let p3 = Position(row: 2, column: 2)
        gameModel3Lines.endTurnWithMove(position: p1, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p2, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p3, player: Player.player1, completion: { (gameOver, winningPositions, winnerPlayer) in
            
            XCTAssertEqual(winnerPlayer, Player.player1)
            XCTAssertTrue(gameOver)
            XCTAssertNotNil(winningPositions)
        })
    }
    
    func testWinnerInRightDiagonal(){
        let p1 = Position(row: 0, column: 2)
        let p2 = Position(row: 1, column: 1)
        let p3 = Position(row: 2, column: 0)
        gameModel3Lines.endTurnWithMove(position: p1, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p2, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p3, player: Player.player1, completion: { (gameOver, winningPositions, winnerPlayer) in
            
            XCTAssertEqual(winnerPlayer, Player.player1)
            XCTAssertTrue(gameOver)
            XCTAssertNotNil(winningPositions)
        })
    }
    
    func testNotWinner(){
        let p1 = Position(row: 1, column: 2)
        let p2 = Position(row: 2, column: 1)
        let p3 = Position(row: 0, column: 1)
        gameModel3Lines.endTurnWithMove(position: p1, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p2, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p3, player: Player.player1, completion: { (gameOver, winningPositions, winnerPlayer) in
            
            XCTAssertNil(winnerPlayer)
            XCTAssertFalse(gameOver)
            XCTAssertNil(winningPositions)
        })
    }
    
    func testDraw(){
        let p1 = Position(row: 0, column: 0)
        let p2 = Position(row: 0, column: 1)
        let p3 = Position(row: 0, column: 2)
        let p4 = Position(row: 1, column: 0)
        let p5 = Position(row: 1, column: 1)
        let p6 = Position(row: 1, column: 2)
        let p7 = Position(row: 2, column: 0)
        let p8 = Position(row: 2, column: 1)
        let p9 = Position(row: 2, column: 2)
        gameModel3Lines.endTurnWithMove(position: p1, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p2, player: Player.player2, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p3, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p5, player: Player.player2, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p4, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p6, player: Player.player2, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p8, player: Player.player1, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p7, player: Player.player2, completion: nil)
        gameModel3Lines.endTurnWithMove(position: p9, player: Player.player1, completion: { (gameOver, winningPositions, winnerPlayer) in
            
            XCTAssertNil(winnerPlayer)
            XCTAssertTrue(gameOver)
            XCTAssertNil(winningPositions)
        })
    }

}
