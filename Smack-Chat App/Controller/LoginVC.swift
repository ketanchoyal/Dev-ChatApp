//
//  LoginVC.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 07/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: AttributedTextColor!
    @IBOutlet weak var passwordTxt: AttributedTextColor!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loginBtn: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.isHidden = true
    }
    
    @IBAction func closePressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        loginBtn.isEnabled = false
        
        AuthService.instance.loginUser(email: email, password: pass, competion: { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                        self.dismiss(animated: true, completion: nil)
                        self.UIUpdate()
                    }
                    else {  self.UIUpdate() }
                })
            }
            else { self.UIUpdate() }
        })
        
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_SIGNUP, sender: nil)
    }
    
    func UIUpdate() {
        self.loginBtn.isEnabled = true
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
}
