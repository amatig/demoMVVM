//
//  ImageDownloadServiceProtocol.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

enum ImageDownloadError: Error {
	case generic
}

protocol ImageDownloadServiceProtocol {
	
	func fetch(url: String, callback: @escaping (Data?, ImageDownloadError?) -> ())
	
}
