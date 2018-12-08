//
//  Constants.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 07/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success : Bool) -> ()

//Segues
let TO_LOGIN = "toLogin"
let TO_SIGNUP = "toCreateAccount"

//User Defaults
let LOGGED_IN_KEY = "loggedin"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

//URL Constants
let BASE_URL = "https://chatappbyketanchoyal.herokuapp.com/v1/"
let URL_REGISTER = BASE_URL + "account/register"
