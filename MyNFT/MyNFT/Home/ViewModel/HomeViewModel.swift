//
//  HomeViewModel.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 28/11/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var nftList: [NftModel] = [NftModel(imageName: "cat"),
                                          NftModel(imageName: "cat2"),
                                          NftModel(imageName: "fishman"),
                                          NftModel(imageName: "fox"),
                                          NftModel(imageName: "fox2"),
                                          NftModel(imageName: "frog"),
                                          NftModel(imageName: "frog2"),
                                          NftModel(imageName: "robo"),
                                          NftModel(imageName: "robo2"),
                                          NftModel(imageName: "ship")]
    
    
    
}
