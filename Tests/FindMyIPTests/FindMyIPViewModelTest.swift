//
//  FindMyIPViewModelTest.swift
//  FindMyIPTests
//
//  Created by Sneha Kalariya on 2024-01-27.
//

import XCTest
@testable import FindMyIP

final class FindMyIPViewModelTest: XCTestCase {

    func test_API_Success() async{
        let webService = MockNetworkManager()
        
        guard let response = webService.readFindMyIPJsonFile() else{
            return
        }
        webService.result1 = .success(response)
        let sut = FindMyIPViewModel(networkManager: webService)
        await sut.callAPI(url: FindMyIPConstants.baseUrl)
        XCTAssertNotNil(sut.responseData)
        
    }
    func test_API_Failuar_responseNil() async{
        let webService = MockNetworkManager()
        webService.result1 = .failure(NetworkError.notAuthenticated)
        let sut = FindMyIPViewModel(networkManager: webService)
        await sut.callAPI(url: FindMyIPConstants.baseUrl)
        XCTAssertNil(sut.responseData)
    }
    
    func test_API_Failuar_checkErrorMsg() async{
        let webService = MockNetworkManager()
        webService.result1 = .failure(NetworkError.notAuthenticated)
        let sut = FindMyIPViewModel(networkManager: webService)
        await sut.callAPI(url: FindMyIPConstants.baseUrl)
        XCTAssertEqual(sut.errorMsg, FindMyIPConstants.apiErrorMsg)
    }
   
}
