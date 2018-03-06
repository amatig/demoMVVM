//
//  Dynamic.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class Dynamic<T> {
	
	typealias Listener = (T) -> ()
	var listener: Listener?
	
	func bind(_ listener: Listener?) {
		self.listener = listener
	}
	
	func bindAndFire(_ listener: Listener?) {
		self.listener = listener
		listener?(value)
	}
	
	var value: T {
		didSet {
			listener?(value)
		}
	}
	
	init(_ v: T) {
		value = v
	}
	
}
