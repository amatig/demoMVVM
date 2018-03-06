//
//  DetailsViewModel.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import Foundation

class DetailsViewModel: NSObject, DetailsViewModelProtocol {
	
	var model: Details
	let service: DetailsServiceProtocol
	let imageService: ImageDownloadServiceProtocol
	
	var name: Dynamic<String>
	var card: Dynamic<Data>
	var phases: Dynamic<[Phase]>
	var inProgress: Dynamic<Bool>
	var inProgressCard: Dynamic<Bool>
	
	// MARK: Init
	
	init(withModel model: Details, service: DetailsServiceProtocol, imageService: ImageDownloadServiceProtocol) {
		self.model = model
		self.service = service
		self.imageService = imageService
		
		self.name = Dynamic(self.model.name)
		self.card = Dynamic(Data())
		self.phases = Dynamic(self.model.phases)
		self.inProgress = Dynamic(false)
		self.inProgressCard = Dynamic(false)
		
		super.init()
		subscribeToNotifications()
	}
	
	deinit {
		unsubscribeFromNotifications()
	}
	
	func fetchData() {
		self.inProgress.value = true
		
		self.service.fetch(procedureId: self.model.id) { (details, error) in
			if error == nil, let details = details {
				self.model.update(details: details)
				
				self.inProgressCard.value = true
				
				self.imageService.fetch(url: self.model.card) { (data, error) in
					if error == nil, let data = data {
						self.card.value = data
					}
					
					self.inProgressCard.value = false
				}
			}
			
			self.inProgress.value = false
		}
	}
	
	func phaseData(at index: Int) -> Phase {
		return self.model.phases[index]
	}
	
	func numberOfRow() -> Int {
		return self.model.phases.count
	}
	
	// MARK: Notifications (Private)
	
	private func subscribeToNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(detailsDidChangeNotification(_:)),
											   name: NSNotification.Name(rawValue: DetailsNotifications.DetailsDidChangeNotification),
											   object: nil)
	}
	
	private func unsubscribeFromNotifications() {
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc private func detailsDidChangeNotification(_ notification: NSNotification) {
		DispatchQueue.main.async {
			self.name.value = self.model.name
			self.phases.value = self.model.phases
		}
	}
	
}
