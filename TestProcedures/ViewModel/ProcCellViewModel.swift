//
//  ProcCellViewModel.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class ProcCellViewModel: NSObject, ProcCellViewModelProtocol {
	
	let model: Procedure
	let service: ImageDownloadServiceProtocol
	
	let name: Dynamic<String>
	let icon: Dynamic<Data>
	var inProgress: Dynamic<Bool>
	
	// MARK: Init
	
	init(withModel model: Procedure, service: ImageDownloadServiceProtocol) {
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
	
	func procedureId() -> String {
		return self.model.id
	}
	
}
