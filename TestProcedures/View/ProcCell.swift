//
//  ProcCell.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import UIKit

class ProcCell: UITableViewCell {
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!
	
	var viewModel: ProcCellViewModelProtocol? {
		didSet {
			fillUI()
		}
	}
	
	override func prepareForReuse() {
		self.nameLabel.text = ""
		self.iconImageView.image = nil
		self.viewModel = nil
	}
	
	// MARK: Private
	
	private func fillUI() {
		guard let viewModel = self.viewModel else {
			return
		}
		
		viewModel.name.bindAndFire { [weak self] in
			self?.nameLabel.text = $0
		}
		viewModel.icon.bind { [weak self] in
			self?.iconImageView.image = UIImage.init(data: $0)
		}
		viewModel.inProgress.bindAndFire { [weak self] in
			if $0 {
				// TODO show activity indicatory on image
			} else {
				// TODO hide activity indicatory on image
			}
		}
		
		viewModel.fetchIcon()
	}
	
}
