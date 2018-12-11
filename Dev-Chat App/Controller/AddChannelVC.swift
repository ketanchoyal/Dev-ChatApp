//
//  AddChannelVC.swift
//  Dev-Chat App
//
//  Created by Ketan Choyal on 10/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var channelTitle: AttributedTextColor!
    @IBOutlet weak var channelDescription: AttributedTextColor!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    @IBAction func createChannelPressed(_ sender: Any) {
        
        guard let name = channelTitle.text , channelTitle.text != "" else { return }
        guard let description = channelDescription.text , channelDescription.text != "" else { return }
        
//        MessageService.instance.addChannel(channelName: name, channelDescription: description, completion: { (success) in
//            if success {
//                self.dismiss(animated: true, completion: nil)
//            }
//        })
        
        SocketService.instance.addChannel(channelName: name, channelDescription: description, completion: { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        })
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func setupView() {
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer : UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
