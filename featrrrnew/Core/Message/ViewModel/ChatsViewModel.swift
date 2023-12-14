//
//  ChatsViewModel.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/10/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import PhotosUI
import SwiftUI

class ChatsViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    @Published var messageImage: Image?
    
    private let service: ChatService
    private var uiImage: UIImage?
            
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeChatMessages()
    }
    
    func observeChatMessages() {
        service.observeMessages { [weak self] messages in
            guard let self = self else { return }
            self.messages.append(contentsOf: messages)
        }
    }
    
    @MainActor
        func sendMessage(_ messageText: String) async throws {
            if let image = uiImage {
                try await service.sendMessage(type: .image(image))
                messageImage = nil
            } else {
                try await service.sendMessage(type: .text(messageText))
            }
        }
        
        func updateMessageStatusIfNecessary() async throws {
            guard let lastMessage = messages.last else { return }
            try await service.updateMessageStatusIfNecessary(lastMessage)
        }
        
        func nextMessage(forIndex index: Int) -> Message? {
            return index != messages.count - 1 ? messages[index + 1] : nil
        }
        
        func removeChatListener() {
            service.removeListener()
        }
    }

extension ChatsViewModel {
    
    @MainActor
    func loadImage() async throws {
        guard let uiImage = try await PhotosPickerHelper.loadImage(fromItem: selectedItem) else { return }
        self.uiImage = uiImage
        messageImage = Image(uiImage: uiImage)
    }
}
    
/*class ChatsViewModel: ObservableObject {
    @Published var messageText = ""
    @Published var messages = [Message]()
    let service: ChatService
    
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observedMessages()
    }
    
    func observedMessages() {
        service.observedMessages() { messages in
            self.messages.append(contentsOf: messages)
        }
    }
    
    func sendMessage() {
       service.sendMessage(messageText)
    }
}*/
