//
//  Player.swift
//  ConnectSwiftlyPackageDescription
//
//  Created by Brychan Bennett-Odlum on 21/01/2018.
//

import Foundation

public class Player: Equatable {
	
	public var key: String!
	
	init(key: String!) {
		self.key = key
	}
	
	public static func ==(lhs: Player, rhs: Player) -> Bool {
		return lhs.key == rhs.key
	}
	
}
