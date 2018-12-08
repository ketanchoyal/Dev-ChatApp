//
//  UserDataService.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 08/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id : String = ""
    public private(set) var email : String = ""
    public private(set) var avatarName : String = ""
    public private(set) var avatarColor : String = ""
    public private(set) var name : String = ""
    
    func setUserData(id : String, name :String, email : String, avatarName : String, avatarColor : String) {
        self.id = id
        self.name = name
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = avatarColor
    }
    
}
