//
//  ProceduresServiceTests.swift
//  TestProceduresTests
//
//  Created by Giovanni Amati on 21/02/18.
//  Copyright © 2018 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TestProcedures

class ProceduresServiceTests: XCTestCase {
	
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
		let service = ProceduresService(baseURL: NetworkingConstants.baseURL, networking: networking)
		
		service.fetch() { (procedures, error) in
			// empty
		}
		
		let expectedEndpoint = "\(NetworkingConstants.baseURL)/procedures"
		
		XCTAssertEqual(networking.endpoint, expectedEndpoint)
	}
	
	func test_GivenNetworkingError_WhenFetch_ThenError() {
		var proceduresFetch: [Procedure]?
		var errorFetched: ProceduresError?
		
		let networking = NetworkingStub()
		networking.errorStub = .generic
		networking.dataStub = nil
		
		let service = ProceduresService(baseURL: NetworkingConstants.baseURL, networking: networking)
		
		service.fetch() { (procedures, error) in
			proceduresFetch = procedures
			errorFetched = error
		}
		
		XCTAssertNotNil(errorFetched)
		XCTAssertNil(proceduresFetch)
	}
	
	func test_GivenData_WhenFetch_ThenSuccess() {
		var proceduresFetch: [Procedure]?
		var errorFetched: ProceduresError?
		
		let networking = NetworkingStub()
		networking.errorStub = nil
		networking.dataStub = ResourseHelper().giveDataProcedures()
		
		let service = ProceduresService(baseURL: NetworkingConstants.baseURL, networking: networking)
		
		service.fetch() { (procedures, error) in
			proceduresFetch = procedures
			errorFetched = error
		}
		
		let exampleProcedures = [
			Procedure(id: "procedure-TSC_PosteriorApproachHip",
					  name: "Posterior Approach to the Hip",
					  icon: "https://s3-eu-west-1.amazonaws.com/media-touchsurgery-dev/media/modules/PosteriorApproachHip/icon/100.jpg")
		]
		
		XCTAssertNil(errorFetched)
		XCTAssertEqual(proceduresFetch!, exampleProcedures)
	}
	
}
