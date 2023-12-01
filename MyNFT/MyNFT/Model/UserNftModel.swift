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
    var nftImageName: String?
    var nftValue: String?
    
    func toDictionary() -> [String: Any] {
        return ["id": self.id, "nftImageName": self.nftImageName, "nftValue": self.nftValue]
    }
    
}
