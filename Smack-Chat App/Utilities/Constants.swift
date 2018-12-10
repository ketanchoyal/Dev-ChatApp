//
//  Constants.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 07/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import Foundation

//Completion handler
typealias CompletionHandler = (_ Success : Bool) -> ()

//Segues
let TO_LOGIN = "toLogin"
let TO_SIGNUP = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3631127477, green: 0.4045833051, blue: 0.8775706887, alpha: 0.5)

//Notification Constants
let NOTIF_USER_DATA_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")
//let NOTIF_KEYBOARD_BOUND = Notification.na

//User Defaults
let LOGGED_IN_KEY = "loggedin"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

//URL Constants
let BASE_URL = "https://chatappbyketanchoyal.herokuapp.com/v1/"
let URL_REGISTER = BASE_URL + "account/register"
let URL_LOGIN = BASE_URL + "account/login"
let URL_CREATE_ADD = BASE_URL + "user/add"
let URL_USER_BY_EMAIL = BASE_URL + "user/byEmail/"
let URL_GET_CHANNLES = BASE_URL + "channel/"
let URL_ADD_CHANNEL = BASE_URL + "channel/add"
let URL_GET_MESSAGES = BASE_URL + "message/byChannel/"

//Headers
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]
