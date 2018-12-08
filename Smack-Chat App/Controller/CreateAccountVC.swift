//
//  CreateAccountVC.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 07/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func closePressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
        
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTxt.text , emailTxt.text != "" else {
            return
        }
        
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {
            return
        }
        
        guard let name = usernameTxt.text , usernameTxt.text != "" else {
            return
        }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, competion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            
                            print("User Created!")
                            self.performSegue(withIdentifier: UNWIND, sender: nil)
                            
                        })
                    }
                })
            }
        }
        
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
        
    }
    
    @IBAction func changeBGPressed(_ sender: Any) {
    }
    
}
