//
//  ViewController.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 05/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //IBOutlet
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var chatChannelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
     
        if AuthService.instance.isLoggedin {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                MessageService.instance.getAllChannels { (success) in
                    
                }
            }
        }
    }

}

