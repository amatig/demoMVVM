//
//  HomeViewModelProtocol.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
	
	var procedures: Dynamic<[Procedure]> { get }
	var inProgress: Dynamic<Bool> { get }
	
	func fetchData()
	func procedureData(at index: Int) -> Procedure
	func numberOfRow() -> Int
	
}
