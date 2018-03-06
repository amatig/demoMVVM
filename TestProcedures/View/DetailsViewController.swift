//
//  DetailsViewController.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
	
	@IBOutlet weak var cardImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	var viewModel: DetailsViewModelProtocol? {
		didSet {
			fillUI()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		fillUI()
		
		guard let viewModel = self.viewModel else {
			return
		}
		
		viewModel.fetchData()
	}
	
	// MARK: Private
	
	private func fillUI() {
		if !isViewLoaded {
			return
		}
		
		guard let viewModel = self.viewModel else {
			return
		}
		
		viewModel.name.bind { [weak self] in
			self?.nameLabel.text = $0
		}
		viewModel.card.bind { [weak self] in
			self?.cardImageView.image = UIImage.init(data: $0)
		}
		viewModel.phases.bind { [weak self] _ in
			self?.tableView.reloadData()
		}
		viewModel.inProgress.bindAndFire { [weak self] in
			if $0 {
				// TODO show activity indicatory
			} else {
				// TODO hide activity indicatory
			}
		}
		viewModel.inProgressCard.bindAndFire { [weak self] in
			if $0 {
				// TODO show activity indicatory on card
			} else {
				// TODO hide activity indicatory on card
			}
		}
	}
	
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = self.viewModel else {
			return 0
		}
		
		return viewModel.numberOfRow()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
		
		if let viewModel = self.viewModel {
			let model = viewModel.phaseData(at: indexPath.row)
			let service = ImageDownloadService(networking: Networking())
			let cellViewModel = DetailCellViewModel(withModel: model, service: service)
			cell.viewModel = cellViewModel
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 70
	}
	
}


