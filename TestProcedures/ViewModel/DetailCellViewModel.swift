//
//  DetailCellViewModel.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class DetailCellViewModel: NSObject, DetailCellViewModelPrototcol {
	
	let model: Phase
	let service: ImageDownloadServiceProtocol
	
	let name: Dynamic<String>
	let icon: Dynamic<Data>
	var inProgress: Dynamic<Bool>
	
	// MARK: Init
	
	init(withModel model: Phase, service: ImageDownloadServiceProtocol) {
		self.model = model
		self.service = service
		
		self.name = Dynamic(self.model.name)
		self.icon = Dynamic(Data())
		self.inProgress = Dynamic(false)
	}
	
	func fetchIcon() {
		self.inProgress.value = true
		
		self.service.fetch(url: self.model.icon) { (data, error) in
			if error == nil, let data = data {
				self.icon.value = data
					
				self.inProgress.value = false
			}
		}
	}
	
}
