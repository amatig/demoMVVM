//
//  DetailsServiceProtocol.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

enum DetailsError: Error {
	case generic
}

protocol DetailsServiceProtocol {
	
	func fetch(procedureId: String, callback: @escaping (Details?, DetailsError?) -> ())
	
}

