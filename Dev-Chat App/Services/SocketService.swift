//
//  SocketService.swift
//  Dev-Chat App
//
//  Created by Ketan Choyal on 10/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    let manger : SocketManager
    let socket : SocketIOClient
    
    override init() {
        self.manger = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manger.defaultSocket
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName : String, channelDescription : String, completion : @escaping CompletionHandler) {
        
        let name = channelName.trimmingCharacters(in: .whitespacesAndNewlines)
        let description = channelDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        
        socket.emit("newChannel", name, description)
        completion(true)
        
    }
    
    func getChannel(completion : @escaping CompletionHandler) {
        
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel.init(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            
            MessageService.instance.channels.append(newChannel)
            
            completion(true)
        }
    }
    
    func addMessage(messageBody : String, channelId : String, completion : @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, user.id, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getMessage(completion : @escaping CompletionHandler) {
        
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else { return }
            guard let userId = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            let newMessage = Message.init(message: messageBody, id: id, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedin {
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                completion(false)
            }
            
//            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedin {
//
//                let newMessage = Message.init(message: messageBody, id: id, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
//
//                MessageService.instance.messages.append(newMessage)
//
//                completion(true)
//
//            } else {
//                completion(false)
//            }
        }
    }
    
    func getTypingUsers(_ completionHandler : @escaping (_ typingUsers : [String : String]) -> Void) {
        
        socket.on("userTypingUpdate") { (dataArray, Ack) in
            guard let typingUsers = dataArray[0] as? [String : String] else { return }
            completionHandler(typingUsers)
        }
    }
    
    func startTyping(userName : String, channelId : String) {
        
        socket.emit("startType", userName, channelId)
        
    }
    
    func stopTyping(userName : String, channelId : String) {
        
        socket.emit("stopType", userName, channelId)
        
    }

}
