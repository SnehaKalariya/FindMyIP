//
//  ServiceManager.swift
//  FindMyIP
//
//  Created by Sneha Kalariya on 2024-01-25.
//

import Foundation
import Combine
import Alamofire

protocol NetworkManagerProtocol {
    func getAPI(_ urlStr: String) async throws -> FindMyIPModel
}

struct NetworkManager: NetworkManagerProtocol {
    func getAPI(_ urlStr: String) async throws -> FindMyIPModel {

        let response = await AF.request(urlStr, interceptor: .retryPolicy)
                    
                               // Automatic Decodable support with background parsing.
                               .serializingDecodable(FindMyIPModel.self)
                               // Await the full response with metrics and a parsed body.
                               .response
        switch response.result{
        case .success(let result):
            return result
        case .failure(let error):
            throw error
        }
       

    }
    
}
