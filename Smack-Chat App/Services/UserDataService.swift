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
    
    func setAvatarName(avatarName : String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor(component : String) -> UIColor {
        //"[0.8509803921568627, 0.30980392156862746, 0.12156862745098039, 1]"
        
        let scanner = Scanner(string: component)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        let rCGFloat = CGFloat(rUnwrapped.doubleValue)
        let gCGFloat = CGFloat(gUnwrapped.doubleValue)
        let bCGFloat = CGFloat(bUnwrapped.doubleValue)
        let aCGFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rCGFloat, green: gCGFloat, blue: bCGFloat, alpha: aCGFloat)
        
        return newUIColor
    }
    
    func logoutUser() {
        
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedin = false
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
        MessageService.instance.clearChannels()
    }
    
}
