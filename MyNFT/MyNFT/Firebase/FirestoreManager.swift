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
    case users
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
        let userCollection = firestore.collection(CollectionKeys.users.rawValue)
        do {
            try userCollection.document(currentUserID).setData(from: user)
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        firestore.collection(CollectionKeys.users.rawValue).document(currentUserID).getDocument { document, error in
            
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
        let userRef = firestore.collection(CollectionKeys.users.rawValue).document(currentUserID)
        let myNft: [String: Any] = [
            "id" : userNftModel.id,
            "nftImageName" : userNftModel.nftImageName,
            "nftValue" : userNftModel.nftValue
        ]
        userRef.updateData(["nftList": FieldValue.arrayRemove([myNft])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func addNewNft(userNft: UserNftModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = firestore.collection(CollectionKeys.users.rawValue).document(currentUserID)
        let myNft: [String: Any] = [
            "id" : userNft.id,
            "nftImageName" : userNft.nftImageName,
            "nftValue" : userNft.nftValue
        ]
        userRef.updateData(["nftList": FieldValue.arrayUnion([myNft])]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    private func getNewNftList(userNft: UserNftModel, completion: @escaping (Result<[UserNftModel], Error>) -> Void) {
        getUserData { result in
            switch result {
            case .success(let user):
                
                let newNftList = (user.nftList?.map { $0.id == userNft.id ? userNft : $0 }) ?? []
                
                completion(.success((newNftList)))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func updateNftList(userNft: UserNftModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = firestore.collection(CollectionKeys.users.rawValue).document(currentUserID)

        getNewNftList(userNft: userNft) { result in
            switch result {
            case .success(let newList):
                let userNftDictionaryArray = newList.map { $0.toDictionary() }
                userRef.updateData(["nftList": userNftDictionaryArray]) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
