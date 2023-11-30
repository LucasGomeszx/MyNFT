//
//  FirestoreManager.swift
//  MyNFT
//
//  Created by Lucas Gomesx on 30/11/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum CollectionKeys: String {
    case user
}

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
    
    func addNewNft(userNftModel: UserNftModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        let myNft: [String: Any] = [
            "id" : userNftModel.id,
            "nftImageName" : userNftModel.imageName ?? "",
            "value" : userNftModel.nftValue ?? ""
        ]
        userRef.updateData(["nftList": FieldValue.arrayUnion([myNft])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
}
