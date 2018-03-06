//
//  DetailsService.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class DetailsService: DetailsServiceProtocol {
	
	private let serviceName = "procedure_details"
	
	private let baseURL: String
	private let networking: NetworkingProtocol
	
	init(baseURL: String, networking: NetworkingProtocol) {
		self.baseURL = baseURL
		self.networking = networking
	}
	
	func fetch(procedureId: String, callback: @escaping (Details?, DetailsError?) -> ()) {
		let queryEncoded = procedureId.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
		let endPoint = "\(baseURL)/\(serviceName)/\(queryEncoded)"
		
		self.networking.httpGET(endpoint: endPoint) { (data, error) in
			guard let data = data, let procedures = try? JSONDecoder().decode(Details.self, from: data) else {
				callback(nil, .generic)
				return
			}
			callback(procedures, nil)
		}
	}
	
}
