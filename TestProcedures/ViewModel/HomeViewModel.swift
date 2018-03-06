//
//  HomeViewModel.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class HomeViewModel: NSObject, HomeViewModelProtocol {
	
	var model: ProceduresList
	let service: ProceduresServiceProtocol
	
	var procedures: Dynamic<[Procedure]>
	var inProgress: Dynamic<Bool>
	
	// MARK: Init
	
	init(withModel model: ProceduresList, service: ProceduresServiceProtocol) {
		self.model = model
		self.service = service
		
		self.procedures = Dynamic(self.model.procedures)
		self.inProgress = Dynamic(false)
		
		super.init()
		subscribeToNotifications()
	}
	
	deinit {
		unsubscribeFromNotifications()
	}
	
	func fetchData() {
		self.inProgress.value = true
		
		self.service.fetch() { (procedures, error) in
			if error == nil, let procedures = procedures {
				self.model.update(procedures: procedures)
			}
			
			self.inProgress.value = false
		}
	}
	
	func procedureData(at index: Int) -> Procedure {
		return self.model[index]
	}
	
	func numberOfRow() -> Int {
		return self.model.count()
	}
	
	// MARK: Notifications (Private)
	
	private func subscribeToNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(proceduresListDidChangeNotification(_:)),
											   name: NSNotification.Name(rawValue: ProceduresListNotifications.ProceduresListDidChangeNotification),
											   object: nil)
	}
	
	private func unsubscribeFromNotifications() {
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc private func proceduresListDidChangeNotification(_ notification: NSNotification) {
		DispatchQueue.main.async {
			self.procedures.value = self.model.procedures
		}
	}
	
}
