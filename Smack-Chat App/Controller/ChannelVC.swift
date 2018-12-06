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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 65
        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "toLogin", sender: nil)
        
    }
}
