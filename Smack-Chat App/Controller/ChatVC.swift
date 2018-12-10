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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_CHANGE, object: nil)
     
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedin {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
            })
        }
    }
    
    @objc func channelSelected(_ notif : Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let chatLabel = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chatChannelLabel.text = "#" + chatLabel
    }
    
    @objc func userDataDidChanged(_ notif : Notification) {
        if AuthService.instance.isLoggedin {
            onLoginGetChannels()
        } else {
            chatChannelLabel.text = "Please Log in"
        }
    }
    
    func onLoginGetChannels() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                //Do stuff
            }
        }
    }

}

