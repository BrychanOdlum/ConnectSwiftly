//
//  Game.swift
//  ConnectSwiftlyPackageDescription
//
//  Created by Brychan Bennett-Odlum on 21/01/2018.
//

import Foundation

public class Game {
	
	public var key: String!
	
	public var host: Player!
	public var guest: Player?
	
	public var turn: Player!
	public var winner: Player?
	
	public var board: Board!
	
	init(key: String!) {
		self.key = key
		self.board = Board(width: 7, height: 6)
		
		let hostKey = Util.generateKey()
		host = Player(key: hostKey)
		
		turn = host
	}
	
	public func guestJoin() -> String? {
		if guest != nil {
			return nil
		}
		
		let guestKey = Util.generateKey()
		guest = Player(key: guestKey)
		
		return guestKey
	}
	
	public func insert(column: Int!, player: Player!) -> Bool {
		if winner != nil {
			return false
		}
		
		if player != turn {
			return false
		}
		
		let _ = board.insert(column: column, player: player)
		
		if turn == host {
			turn = guest
		} else {
			turn = host
		}
		
		for r in (0...board.height).reversed() {
			let cell = board.getCell(coord: Coord(column: column, row: r))
			
			if cell == player {
				if board.countAdjacent(column: column, row: r) >= 4 {
					winner = player
				}
				
				break
			}
		}
		
		return true
	}
	
	public func detectVictory(column: Int!, row: Int!) -> Bool {
		return board.countAdjacent(column: column, row: row) >= 4
	}
	
	public func getPlayer(key: String!) -> Player? {
		if host.key == key {
			return host
		} else if guest?.key == key {
			return guest!
		}
		return nil
	}
}
