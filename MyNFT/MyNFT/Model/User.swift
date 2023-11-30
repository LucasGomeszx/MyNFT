//
//  User.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import Foundation

struct User: Codable {
    var id: String?
    var nftList: [UserNftModel]?
}
