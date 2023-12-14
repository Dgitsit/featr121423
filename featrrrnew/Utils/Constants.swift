//
//  Constants.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/25/23.
//

import Foundation

import Firebase




let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")



struct FirestoreConstants {
    static let Root = Firestore.firestore()
    
    static let UsersCollection = Root.collection("users")
    
    static let MessagesCollection = Root.collection("messages")
}
