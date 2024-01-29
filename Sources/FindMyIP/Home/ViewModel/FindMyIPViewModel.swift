//
//  FindMyIPViewModel.swift
//  FindMyIP
//
//  Created by Sneha Kalariya on 2024-01-25.
//

import Foundation
import Combine

protocol FindMyIPViewModelProtocol{
    func callAPI(url:String) async
    var responseData : FindMyIPModel? {get set}
     var errorMsg : String {get set}
}

class FindMyIPViewModel : ObservableObject, FindMyIPViewModelProtocol {
    
    private var networkManager : NetworkManagerProtocol
    @Published var responseData : FindMyIPModel?
    @Published var errorMsg = ""
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    //MARK: - API call
    func callAPI(url:String) async{
            do{
                let result = try await self.networkManager.getAPI(url)
                await MainActor.run { [result] in
                    self.responseData = result
                }
            }catch{
                print("error == \(error.localizedDescription)")
                await MainActor.run{
                    self.errorMsg = FindMyIPConstants.apiErrorMsg

                }
            }
       
        
    }

}
