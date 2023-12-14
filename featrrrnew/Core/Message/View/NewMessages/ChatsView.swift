//
//  ChatsView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 8/9/23.
//

import SwiftUI

struct ChatsView: View {
    @State private var messageText = ""
    @State private var isInitialLoad = false
    @StateObject var viewModel: ChatsViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatsViewModel(user: user))
    }
    
    
    var body: some View {
        
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        VStack {
                            CircularProfileImageView(user: user)
                            
                            VStack(spacing: 4) {
                                Text(user.username)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Text("Messenger")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        ForEach(viewModel.messages) { message in
                            ChatsMessageCell(message: message, user: user)
                        }
                        
                        /*let messageIndices = viewModel.messages.indices
                        
                        let messageCellClosure:(Int)-> ChatsMessageCell = {index in
                            let message = viewModel.messages[index]
                            let nextMessage = viewModel.nextMessage(forIndex: index)
                            return ChatsMessageCell(message: message, nextMessage: nextMessage)
                        }
                        
                        let idClosure: (Int) -> AnyHashable = {index in
                            return viewModel.messages[index].id
                        }
                        
                        ForEach(messageIndices, id: idClosure, content: messageCellClosure)*/
                        /*ForEach(viewModel.messages.indices, id: \.self) { index in
                            ChatsMessageCell(message: viewModel.messages[index],
                                            nextMessage: viewModel.nextMessage(forIndex: index))
                                .id(viewModel.messages[index].id)
                        }*/
                    }
                    .padding(.vertical)
                }
                .onChange(of: viewModel.messages) { newValue in
                    guard  let lastMessage = newValue.last else { return }
            
                    withAnimation(.spring()) {
                        proxy.scrollTo(lastMessage.id)
                    }
                }
            }
            
            Spacer()
            
            MessageInputView(messageText: $messageText, viewModel: viewModel)
        }
        .onDisappear {
            viewModel.removeChatListener()
        }
        .onChange(of: viewModel.messages, perform: { _ in
            Task { try await viewModel.updateMessageStatusIfNecessary()}
    })
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView(user: dev.user)
    }
}
    
    
    //@State private var messageText = ""
    /*var body: some View {
        VStack {
            ScrollView {
                VStack {
                    CircularProfileImageView(user: user)
                    
                    VStack(spacing: 4) {
                        Text(user.username)
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                ForEach(viewModel.messages) { message in
                    ChatsMessageCell(message: message, user: user)
                }
            }
            
            ZStack(alignment: .trailing) {
                TextField("Detail your vision..", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 40)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                Button {
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}*/


