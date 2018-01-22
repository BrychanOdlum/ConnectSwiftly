//
//  Coord.swift
//  ConnectSwiftlyPackageDescription
//
//  Created by Brychan Bennett-Odlum on 21/01/2018.
//

import Foundation

public class Coord: Equatable, Hashable {
	
	public var column: Int!
	public var row: Int!
	
	init(column: Int!, row: Int!) {
		self.column = column
		self.row = row
	}
	
	public static func ==(lhs: Coord, rhs: Coord) -> Bool {
		return lhs.column == rhs.column && lhs.row == rhs.row
	}
	
	public var hashValue: Int {
		return column.hashValue ^ row.hashValue &* 16777619
	}
	
}
