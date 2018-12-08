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
                
                self.loginUser(email: lowerCaseEmail, password: password, competion: { (success) in
                    
                    print("logged in user!", self.authToken)
                    
                })
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
    
}
