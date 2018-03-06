//
//  DetailsServiceTests.swift
//  TestProceduresTests
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TestProcedures

class DetailsServiceTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func test_GivenBaseURL_WhenFetch_ThenEndpointCorrect() {
		let networking = NetworkingStub()
		let service = DetailsService(baseURL: NetworkingConstants.baseURL, networking: networking)
		
		service.fetch(procedureId: "procedure-TSC_DPapproach") { (procedures, error) in
			// empty
		}
		
		let queryEncoded = "procedure-TSC_DPapproach".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
		let expectedEndpoint = "\(NetworkingConstants.baseURL)/procedure_details/\(queryEncoded)"
		
		XCTAssertEqual(networking.endpoint, expectedEndpoint)
	}
	
	func test_GivenNetworkingError_WhenFetch_ThenError() {
		var detailsFetch: Details?
		var errorFetched: DetailsError?
		
		let networking = NetworkingStub()
		networking.errorStub = .generic
		networking.dataStub = nil
		
		let service = DetailsService(baseURL: NetworkingConstants.baseURL, networking: networking)
		
		service.fetch(procedureId: "fake") { (details, error) in
			detailsFetch = details
			errorFetched = error
		}
		
		XCTAssertNotNil(errorFetched)
		XCTAssertNil(detailsFetch)
	}
	
	func test_GivenData_WhenFetch_ThenSuccess() {
		var detailsFetch: Details?
		var errorFetched: DetailsError?
		
		let networking = NetworkingStub()
		networking.errorStub = nil
		networking.dataStub = ResourseHelper().giveDataDetails()
		
		let service = DetailsService(baseURL: NetworkingConstants.baseURL, networking: networking)
		
		service.fetch(procedureId: "fake") { (details, error) in
			detailsFetch = details
			errorFetched = error
		}
		
		let exampleDetails =
			Details(id: "procedure-TSC_DPapproach",
					name: "Anterior approach shoulder",
					icon: "https://s3-eu-west-1.amazonaws.com/media-touchsurgery-dev/media/modules/DPapproach/icon/100.jpg",
					card: "https://s3-eu-west-1.amazonaws.com/media-touchsurgery-dev/media/modules/DPapproach/card/100.jpg",
					phases: [
						Phase(name: "Anterior approach shoulder",
							  icon: "https://s3-eu-west-1.amazonaws.com/media-touchsurgery-dev/media/modules/DPapproach/icon/100.jpg")])
		
		XCTAssertNil(errorFetched)
		XCTAssertEqual(detailsFetch!, exampleDetails)
	}
	
}
