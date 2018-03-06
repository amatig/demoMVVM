//
//  ProceduresList.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

enum ProceduresListNotifications {
	static let ProceduresListDidChangeNotification = "ProceduresListDidChangeNotification"
}

struct ProceduresList {
	
	// MARK: Data
	
	var procedures: [Procedure]
	
	// MARK: Accessing
	
	subscript(index: Int) -> Procedure {
		return self.procedures[index]
	}
	
	func count() -> Int {
		return self.procedures.count
	}
	
	mutating func update(procedures: [Procedure]) {
		self.procedures = procedures
		
		NotificationCenter.default.post(name: Notification.Name(rawValue: ProceduresListNotifications.ProceduresListDidChangeNotification),
										object: self)
	}
	
}
