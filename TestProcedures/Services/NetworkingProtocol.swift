//
//  NetworkingProtocol.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
	case generic
	case status(code: Int)
	case invalidEndpoint
}

protocol NetworkingProtocol {
	
	func httpGET(endpoint: String,
				 completion: @escaping (Data?, NetworkingError?) -> ())
	
}
