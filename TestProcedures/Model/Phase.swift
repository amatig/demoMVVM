//
//  Phase.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

struct Phase: Codable, Equatable {
	static func ==(lhs: Phase, rhs: Phase) -> Bool {
		return lhs.icon == rhs.icon && lhs.name == rhs.name
	}
	
	// MARK: Data
	
	var name: String
	var icon: String
	
}
