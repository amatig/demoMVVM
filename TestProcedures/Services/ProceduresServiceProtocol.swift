//
//  ProceduresServiceProtocol.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

enum ProceduresError: Error {
	case generic
}

protocol ProceduresServiceProtocol {
	
	func fetch(callback: @escaping ([Procedure]?, ProceduresError?) -> ())
	
}
