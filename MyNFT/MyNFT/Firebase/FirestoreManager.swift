//
//  FirestoreManager.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct FirestoreManager {
    
    static let shared = FirestoreManager()
    
    private let firestore: Firestore
    
    private init() {
        firestore = Firestore.firestore()
    }
    
    private var currentUserID: String {
        guard let userId = Auth.auth().currentUser?.uid else { return ""}
        return userId
    }
    
    func createUser(completion: @escaping (Error?) -> Void) {
        let user = User(id: currentUserID, nftList: [])
        let userCollection = firestore.collection("user")
        do {
            try userCollection.document(currentUserID).setData(from: user)
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    
}
