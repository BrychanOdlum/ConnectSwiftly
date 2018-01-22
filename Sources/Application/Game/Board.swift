//
//  Board.swift
//  ConnectSwiftlyPackageDescription
//
//  Created by Brychan Bennett-Odlum on 21/01/2018.
//

import Foundation

public class Board {
	
	public var width: Int
	public var height: Int
	private var cells: [Coord: Player] = [:]
	
	init(width: Int, height: Int) {
		self.width = width
		self.height = height
	}
	
	public func getCell(coord: Coord) -> Player? {
		return cells[coord]
	}
	
	func insert(column: Int, player: Player) -> Bool {
		for row in 0..<height {
			let coord = Coord(column: column, row: row)
			if cells[coord] == nil {
				cells[coord] = player
				return true
			}
		}
		
		return false
	}
	
	public func countAdjacent(column: Int, row: Int) -> Int! {
		let player: Player = cells[Coord(column: column, row: row)]!
		var maxCount = 0
		var c: Int!, r: Int!, count: Int!
		
		// Horizontal
		c = column
		r = row
		count = 1
		while adjacentCell(column: c, row: r, cDisp: -1, rDisp: 0) == player {
			c! -= 1
		}
		while adjacentCell(column: c, row: r, cDisp: 1, rDisp: 0) == player {
			c! += 1
			count! += 1
		}
		if count > maxCount {
			maxCount = count
		}
		
		// Vertical
		c = column
		r = row
		count = 1
		while adjacentCell(column: c, row: r, cDisp: 0, rDisp: -1) == player {
			r! -= 1
		}
		while adjacentCell(column: c, row: r, cDisp: 0, rDisp: 1) == player {
			r! += 1
			count! += 1
		}
		if count > maxCount {
			maxCount = count
		}
		
		// Diag1
		c = column
		r = row
		count = 1
		while adjacentCell(column: c, row: r, cDisp: -1, rDisp: -1) == player {
			c! -= 1
			r! -= 1
		}
		while adjacentCell(column: c, row: r, cDisp: 1, rDisp: 1) == player {
			c! += 1
			r! += 1
			count! += 1
		}
		if count > maxCount {
			maxCount = count
		}
		
		// Diag2
		c = column
		r = row
		count = 1
		while adjacentCell(column: c, row: r, cDisp: -1, rDisp: 1) == player {
			c! -= 1
			r! += 1
		}
		while adjacentCell(column: c, row: r, cDisp: 1, rDisp: -1) == player {
			c! += 1
			r! -= 1
			count! += 1
		}
		if count > maxCount {
			maxCount = count
		}
		
		return maxCount
	}
	
	private func adjacentCell(column: Int!, row: Int!, cDisp: Int!, rDisp: Int!) -> Player? {
		let nColumn = column + cDisp
		let nRow = row + rDisp
		
		if nColumn < 0 || nColumn >= width {
			return nil
		}
		if nRow < 0 || nColumn >= height {
			return nil
		}
		
		return cells[Coord(column: nColumn, row: nRow)]
	}
	
}
