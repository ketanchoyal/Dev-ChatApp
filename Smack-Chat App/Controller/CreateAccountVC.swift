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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var createAccountBtn: RoundedButton!
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let imageName = UserDataService.instance.avatarName
        
        if imageName != "" {
            userImage.image = UIImage(named: imageName)
            avatarName = imageName
            if avatarName.contains("light") && bgColor == nil {
                userImage.backgroundColor = UIColor.lightGray
            }
        }
        
    }

    @IBAction func closePressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
        
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        createAccountBtn.isEnabled = false
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, competion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                self.UIUpdate()
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                            }
                            else { self.UIUpdate() }
                        })
                    }
                    else { self.UIUpdate() }
                })
            }
            else { self.UIUpdate() }
        }
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
        
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
        //Random Color Generation RGB
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        
        avatarColor = "[\(r), \(g), \(b), 1]"
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.userImage.backgroundColor = self.bgColor
        }
    }
    
    func setupView() {
        spinner.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action:  #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func UIUpdate() {
        self.createAccountBtn.isEnabled = true
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    
}
