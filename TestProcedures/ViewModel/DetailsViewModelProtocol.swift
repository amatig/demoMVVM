//
//  DetailsViewModelProtocol.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

protocol DetailsViewModelProtocol {
	
	var name: Dynamic<String> { get }
	var card: Dynamic<Data> { get }
	var phases: Dynamic<[Phase]> { get }
	var inProgress: Dynamic<Bool> { get }
	var inProgressCard: Dynamic<Bool> { get }
	
	func fetchData()
	func phaseData(at index: Int) -> Phase
	func numberOfRow() -> Int
	
}
