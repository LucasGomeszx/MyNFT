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
            "nftImageName" : userNftModel.nftImageName ?? "",
            "nftValue" : userNftModel.nftValue ?? ""
        ]
        userRef.updateData(["nftList": FieldValue.arrayUnion([myNft])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        firestore.collection(CollectionKeys.user.rawValue).document(currentUserID).getDocument { document, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(NSError(domain: "FirestoreManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Documento não existe ou houve um erro"])))
                return
            }
            
            do {
                let user = try document.data(as: User.self)
                completion(.success(user))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func deleteNewNft(userNftModel: UserNftModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = firestore.collection(CollectionKeys.user.rawValue).document(currentUserID)
        let myNft: [String: Any] = [
            "id" : userNftModel.id,
            "nftImageName" : userNftModel.nftImageName ?? "",
            "nftValue" : userNftModel.nftValue ?? ""
        ]
        userRef.updateData(["nftList": FieldValue.arrayRemove([myNft])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
}
