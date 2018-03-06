//
//  Details.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

enum DetailsNotifications {
	static let DetailsDidChangeNotification = "DetailsDidChangeNotification"
}

struct Details: Codable, Equatable {
	static func ==(lhs: Details, rhs: Details) -> Bool {
		return lhs.id == rhs.id && lhs.name == rhs.name && lhs.icon == rhs.icon && lhs.card == rhs.card && lhs.phases == rhs.phases
	}
	
	// MARK: Data
	
	var id: String
	var name: String
	var icon: String
	var card: String
	var phases: [Phase]
	
	// MARK: Accessing
	
	mutating func update(details: Details) {
		self.id = details.id
		self.name = details.name
		self.icon = details.icon
		self.card = details.card
		self.phases = details.phases
		
		NotificationCenter.default.post(name: Notification.Name(rawValue: DetailsNotifications.DetailsDidChangeNotification),
										object: self)
	}
	
}
