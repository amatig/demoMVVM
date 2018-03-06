//
//  Networking.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

enum NetworkingConstants {
	static let baseURL = "http://localhost:3000"
}

class Networking: NetworkingProtocol {
	
	var session: URLSession
	
	init() {
		self.session = URLSession(configuration: URLSessionConfiguration.default)
	}
	
	func httpGET(endpoint: String,
				 completion: @escaping (Data?, NetworkingError?) -> ())
	{
		guard let url = URL(string: endpoint) else {
			completion(nil, .invalidEndpoint)
			return
		}
		let dataTask = self.session.dataTask(with: url) { (data, response, error) in
			guard error == nil else {
				DispatchQueue.main.async {
					completion(nil, .generic)
				}
				return
			}
			DispatchQueue.main.async {
				completion(data, nil)
			}
		}
		dataTask.resume()
	}
	
}
