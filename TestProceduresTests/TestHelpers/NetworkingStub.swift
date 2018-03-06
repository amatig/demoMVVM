//
//  NetworkingStub.swift
//  TestProceduresTests
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation
@testable import TestProcedures

class NetworkingStub: NetworkingProtocol {
	
	var dataStub: Data?
	var errorStub: NetworkingError?
	var endpoint: String?
	
	func httpGET(endpoint: String, completion: @escaping (Data?, NetworkingError?) -> ()) {
		self.endpoint = endpoint
		
		if errorStub != nil {
			completion(nil, errorStub!)
		} else {
			completion(dataStub, nil)
		}
	}
	
}

