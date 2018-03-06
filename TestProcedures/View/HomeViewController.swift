//
//  HomeViewController.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

	var viewModel: HomeViewModelProtocol? {
		didSet {
			fillUI()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		fillUI()
		
		guard let viewModel = self.viewModel else {
			return
		}
		
		viewModel.fetchData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "detailsSegue" {
			if let destinationVC = segue.destination as? DetailsViewController {
				let cell = sender as! ProcCell
				let id = cell.viewModel != nil ? cell.viewModel!.procedureId() : ""
				
				let model = Details(id: id, name: "", icon: "", card: "", phases: [])
				let service = DetailsService(baseURL: NetworkingConstants.baseURL, networking: Networking())
				let imageService = ImageDownloadService(networking: Networking())
				let viewModel = DetailsViewModel(withModel: model, service: service, imageService: imageService)
				destinationVC.viewModel = viewModel
			}
		}
	}
	
	// MARK: Private
	
	private func fillUI() {
		if !isViewLoaded {
			return
		}
		
		guard let viewModel = self.viewModel else {
			return
		}
		
		viewModel.procedures.bind { [weak self] _ in
			self?.tableView.reloadData()
		}
		viewModel.inProgress.bindAndFire { [weak self] in
			if $0 {
				// TODO show activity indicatory
			} else {
				// TODO hide activity indicatory
			}
		}
	}
	
}

extension HomeViewController {
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = self.viewModel else {
			return 0
		}
		
		return viewModel.numberOfRow()
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "procCell", for: indexPath) as! ProcCell
		
		if let viewModel = self.viewModel {
			let model = viewModel.procedureData(at: indexPath.row)
			let service = ImageDownloadService(networking: Networking())
			let cellViewModel = ProcCellViewModel(withModel: model, service: service)
			cell.viewModel = cellViewModel
		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
}

