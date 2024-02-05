//
//  DatabaseManager.swift
//  chatApp
//
//  Created by Alibek Allamzharov on 05.02.2024.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
     
}

// MARK: - Account Management

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    /// inserts new user to Database
    public func insertUser(with user: ChatAppUser) {
        
        database.child(user.emailAddress).setValue([
            "first_name": user.name,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser{
    let name: String
    let lastName: String
    let emailAddress: String
//    let profilePictureUrl: String
}
