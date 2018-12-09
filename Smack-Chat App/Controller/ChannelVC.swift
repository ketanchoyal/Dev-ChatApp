//
//  ChannelVC.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 05/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    @IBOutlet weak var userImage: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 65
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChanged(_:)), name: NOTIF_USER_DATA_CHANGE, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedin {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidChanged(_ notif : Notification) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedin {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.returnUIColoe(component: UserDataService.instance.avatarColor)
        }
        else {
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
}
