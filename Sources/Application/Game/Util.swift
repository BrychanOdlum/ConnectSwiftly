//
//  Util.swift
//  ConnectSwiftlyPackageDescription
//
//  Created by Brychan Bennett-Odlum on 21/01/2018.
//

import Foundation

public class Util {
	
	public static func generateKey() -> String {
		var key = ""
		var charsString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		var chars = [Character](charsString.characters)
		for _ in 0..<10 {
			let rand = arc4random_uniform(UInt32(chars.count))
			key.append(chars[Int(rand)])
		}
		return key
	}
	
}
