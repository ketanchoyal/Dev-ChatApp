//
//  AuthService.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 08/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedin : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email : String, password : String, completion : @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString {
            (response) in
            
            if response.result.error == nil {
                completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email : String, password : String, competion : @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedin = true
                competion(true)
            }
            else {
                competion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    func createUser(name : String, email : String, avatarName : String, avatarColor : String, completion : @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "name" : name,
            "email" : lowerCaseEmail,
            "avatarName" : avatarName,
            "avatarColor" : avatarColor
        ]
        
        let header = [
            "Authorization" : "Bearer \(self.authToken)",
            "Content-Type" : "application/json; charset=utf-8"
        ]
        
        Alamofire.request(URL_CREATE_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                let json = JSON(data: data)
                
                let id = json["_id"].stringValue
                let avatarName = json["avatarName"].stringValue
                let avatarColor = json["avatarColor"].stringValue
                let name = json["name"].stringValue
                let email = json["email"].stringValue
                
                UserDataService.instance.setUserData(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor)
                completion(true)
                
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
}
