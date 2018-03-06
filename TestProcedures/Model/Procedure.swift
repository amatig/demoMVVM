//
//  Procedure.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

struct Procedure: Codable, Equatable {
	static func ==(lhs: Procedure, rhs: Procedure) -> Bool {
		return lhs.id == rhs.id && lhs.name == rhs.name && lhs.icon == rhs.icon
	}
	
	// MARK: Data
	
	var id: String
	var name: String
	var icon: String
	
}
