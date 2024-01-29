//
//  MockNetworkManager.swift
//  FindMyIPTests
//
//  Created by Sneha Kalariya on 2024-01-27.
//

import Foundation
@testable import FindMyIP

final class MockNetworkManager: NetworkManagerProtocol{
    var result1: Result<FindMyIPModel, Error>!
    func getAPI(_ urlStr: String) async throws -> FindMyIPModel{
        switch result1{
            case .success(let result):
                return result
            case .failure(let error):
                throw error
            case .none:
            throw NetworkError.badRequest
        }
    }
    
    func readFindMyIPJsonFile() -> FindMyIPModel?{
        do{
            guard let filePath = Bundle.main.path(forResource: "Response", ofType: "json") else{
                return nil
            }
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            let findMyIPData = try JSONDecoder().decode(FindMyIPModel.self, from: data)
            return findMyIPData
            
        }catch _{
            return nil
        }
    }
}
enum NetworkError: Error {
    case badRequest
    case decodingError
    case notAuthenticated
}
