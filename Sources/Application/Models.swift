//
//  Models.swift
//  ConnectSwiftlyPackageDescription
//
//  Created by Brychan Bennett-Odlum on 21/01/2018.
//

import Foundation

class ErrorJSON: Codable {
	let Status = -1
}

class SuccessJSON: Codable {
	let Status = 1
}

struct CreateGame: Codable {
	var GameID: String
	var HostID: String
	
	init(gameID: String, hostID: String) {
		GameID = gameID
		HostID = hostID
	}
}

struct FetchGame: Codable {
	var GuestPlayer: Bool
	var Turn: Bool
	var Winner: Int
	var Cells: [[Int]]
	
	init(board: Board!, host: Player!, guest: Bool, turn: Bool, winner: Player?) {
		GuestPlayer = guest
		Turn = turn
		Winner = winner == host ? 2 : winner != nil ? 1 : 0
		
		var intCells = [[Int]](repeating: [], count: board.width)
		for c in 0..<board.width {
			var intColumn = [Int](repeating: 0, count: board.height)
			for r in 0..<board.height {
				let p = board.getCell(coord: Coord(column: c, row: r))
				intColumn[r] = p == host ? 2 : p != nil ? 1 : 0
			}
			intCells[c] = intColumn
		}
		Cells = intCells
	}
}

struct JoinGame: Codable {
	var GuestID: String
	
	init(guestID: String!) {
		GuestID = guestID
	}
}
