//
//  AppDelegate.swift
//  TestProcedures
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		let navigator = self.window?.rootViewController as! UINavigationController
		let controller = navigator.viewControllers[0] as! HomeViewController
		
		let model = ProceduresList(procedures: [])
		let service = ProceduresService(baseURL: NetworkingConstants.baseURL, networking: Networking())
		let viewModel = HomeViewModel(withModel: model, service: service)
		controller.viewModel = viewModel
		
		return true
	}

}

