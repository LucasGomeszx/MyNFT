//
//  UserNftModel.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import Foundation

struct UserNftModel: Codable {
    var id: UUID = UUID()
    var imageName: String?
    var nftValue: String?
}
