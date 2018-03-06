//
//  ProceduresService.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class ProceduresService: ProceduresServiceProtocol {
	
	private let serviceName = "procedures"
	
	private let baseURL: String
	private let networking: NetworkingProtocol
	
	init(baseURL: String, networking: NetworkingProtocol) {
		self.baseURL = baseURL
		self.networking = networking
	}
	
	func fetch(callback: @escaping ([Procedure]?, ProceduresError?) -> ()) {
		let endPoint = "\(baseURL)/\(serviceName)"
		
		self.networking.httpGET(endpoint: endPoint) { (data, error) in
			guard let data = data, let procedures = try? JSONDecoder().decode([Procedure].self, from: data) else {
				callback(nil, .generic)
				return
			}
			callback(procedures, nil)
		}
	}
	
}
