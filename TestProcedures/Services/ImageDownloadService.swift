//
//  ImageDownloadService.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class ImageDownloadService: ImageDownloadServiceProtocol {
	
	private let networking: NetworkingProtocol
	
	init(networking: NetworkingProtocol) {
		self.networking = networking
	}
	
	func fetch(url: String, callback: @escaping (Data?, ImageDownloadError?) -> ()) {
		let queryEncoded = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
		
		self.networking.httpGET(endpoint: queryEncoded) { (data, error) in
			guard let data = data else {
				callback(nil, .generic)
				return
			}
			callback(data, nil)
		}
	}
	
}
