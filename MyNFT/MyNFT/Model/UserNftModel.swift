//
//  UserNftModel.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserNftModel: Codable, Identifiable {
    var id: String = UUID().uuidString
    var imageName: String?
    var nftValue: String?
}
