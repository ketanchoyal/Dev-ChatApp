//
//  MessageService.swift
//  Dev-Chat App
//
//  Created by Ketan Choyal on 10/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var unreadChannels = [String]()
    
    var selectedChannel : Channel?
    
    func findAllChannels(completion : @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNLES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array {
                    for items in json {
                        let id = items["_id"].stringValue
                        let channelTitle = items["name"].stringValue
                        let channelDescription = items["description"].stringValue
                        
                        let channel = Channel.init(channelTitle: channelTitle, channelDescription: channelDescription, id: id)
                        
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
//    func addChannel(channelName : String, channelDescription : String, completion : @escaping CompletionHandler) {
//        let name = channelName.trimmingCharacters(in: .whitespacesAndNewlines)
//        let description = channelDescription.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        let body : [String : Any] = [
//            "name" : name,
//            "description" : description
//        ]
//        
//        Alamofire.request(URL_ADD_CHANNEL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
//            if response.result.error == nil {
//                completion(true)
//            }
//            else {
//                completion(false)
//                debugPrint(response.result.error as Any)
//            }
//        }
//    }
    
    func findAllMessagesForChannel(channelID : String, completion : @escaping CompletionHandler) {
        clearMessages()
        Alamofire.request(URL_GET_MESSAGES + channelID, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let id = item["_id"].stringValue
                        let userId = item["userId"].stringValue
                        let channelId = item["channelId"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message.init(message: messageBody, id: id, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                        
                        self.messages.append(message)
                    }
                    completion(true)
                    //print(self.messages)
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
}
