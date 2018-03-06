//
//  DetailCellViewModelPrototcol.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

protocol DetailCellViewModelPrototcol {
	
	var name: Dynamic<String> { get }
	var icon: Dynamic<Data> { get }
	var inProgress: Dynamic<Bool> { get }
	
	func fetchIcon()
	
}
