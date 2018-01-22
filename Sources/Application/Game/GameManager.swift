//
//  GuestManager.swift
//  ConnectSwiftlyPackageDescription
//
//  Created by Brychan Bennett-Odlum on 21/01/2018.
//

import Foundation

public class GameManager {
	
	private var games: [String: Game] = [:]
	
	public init() {
		
	}
	
	public func createGame() -> Game {
		var code: String? = nil
		while code == nil {
			let cc = Util.generateKey()
			if games[cc] == nil {
				code = cc
			}
		}
		
		let game = Game(key: code!)
		games[code!] = game
		
		return game
	}
	
	public func getGame(id: String!) -> Game? {
		return games[id]
	}
	
}
