//
//  ResourceHelper.swift
//  TestProceduresTests
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class ResourseHelper {
	
	func giveDataProcedures() -> Data {
		let bundle = Bundle(for: type(of: self))
		let path = bundle.path(forResource: "procedures", ofType: "json")!
		let string = try! String(contentsOfFile: path, encoding: .utf8)
		return string.data(using: .utf8)!
	}
	
	func giveDataDetails() -> Data {
		let bundle = Bundle(for: type(of: self))
		let path = bundle.path(forResource: "details", ofType: "json")!
		let string = try! String(contentsOfFile: path, encoding: .utf8)
		return string.data(using: .utf8)!
	}
	
}
