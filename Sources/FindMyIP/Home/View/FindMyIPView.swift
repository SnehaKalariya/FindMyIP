//
//  ContentView.swift
//  FindMyIP
//
//  Created by Sneha Kalariya on 2024-01-25.
//

import SwiftUI

public struct FindMyIPView: View {
    @ObservedObject var viewModel : FindMyIPViewModel = FindMyIPViewModel(networkManager: NetworkManager())
    public init(){
        
    }
    public var body: some View {
        NavigationStack{
            VStack {
                if viewModel.responseData == nil && viewModel.errorMsg == ""{
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(2)
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                        .background(.black.opacity(0.0))
                    
                }else{
                    ScrollView{
                        ShowDataOrError(vm: viewModel)
                    }
                }
            }
            .task {
                await viewModel.callAPI(url: FindMyIPConstants.baseUrl)
            }
            .frame(maxWidth: .infinity,maxHeight:.infinity)
            .background(.blue.opacity(0.3))
            .navigationTitle("Find My IP")
            .fontWeight(.regular)
        }
        
    }
    
    //MARK: - ViewBuilder
    @ViewBuilder
    func ShowDataOrError(vm : FindMyIPViewModel) -> some View{
        if let responseData = vm.responseData{
            VStack(spacing:15){
                VStack(spacing:10){
                    Text("IP details")
                        .modifier(WhiteBoldText())
                    cellCreator("IP", responseData.ip ?? "")
                    cellCreator("Network", responseData.network ?? "")
                    cellCreator("Version", responseData.version ?? "")
                }
                .modifier(SectionModifier())
                VStack(spacing:10){
                    Text("Location details")
                        .modifier(WhiteBoldText())
                    cellCreator("Country name", responseData.countryName ?? "")
                    cellCreator("City", "\(responseData.city ?? ""), \(responseData.region ?? "")")
                    cellCreator("Postal", responseData.postal ?? "")
                    cellCreator("Lat & Long", "\(responseData.latitude ?? 0), \(responseData.longitude ?? 0)")
                }
                .modifier(SectionModifier())
                VStack(spacing:10){
                    Text("Country details")
                        .modifier(WhiteBoldText())
                    cellCreator("Country code", responseData.countryCode ?? "")
                    cellCreator("Country capital", responseData.countryCapital ?? "")
                    cellCreator("Languages", responseData.languages ?? "")
                    cellCreator("Country area", "\(responseData.countryArea ?? 0)")
                    cellCreator("Country population", "\(responseData.countryPopulation ?? 0)")
                }
                .modifier(SectionModifier())
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))

        }else{
            Text(vm.errorMsg)
            .padding(EdgeInsets(top: 20, leading: -10, bottom: 0, trailing: 0))
            .foregroundColor(.red)
            Spacer()
        }
    }
    @ViewBuilder
    func cellCreator(_ title : String, _ details : String) -> some View{
        HStack(spacing: 10){
            Text(title)
                .modifier(WhiteTitleText())
            Text(details)
                .modifier(DetailText())
            Spacer()
        }
    }
}

struct FindMyIPView_Previews: PreviewProvider {
    static var previews: some View {
        FindMyIPView()
    }
}
