//
//  ViewController.swift
//  Smack-Chat App
//
//  Created by Ketan Choyal on 05/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //IBOutlet
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var chatChannelLabel: UILabel!
    @IBOutlet weak var messageTxtBox: AttributedTextColor!
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    //Variable
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        
        messageTable.delegate = self
        messageTable.dataSource = self
        
        sendBtn.isHidden = true
        
        messageTable.estimatedRowHeight = 80
        messageTable.rowHeight = UITableView.automaticDimension
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action:  #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getMessage { (success) in
            if success {
                self.messageTable.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    
                    self.messageTable.scrollToRow(at: endIndex, at: UITableView.ScrollPosition.bottom, animated: true)
                }
            }
        }
        
        if AuthService.instance.isLoggedin {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
            })
        }
    }
    
    @objc func channelSelected(_ notif : Notification) {
        updateWithChannel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func updateWithChannel() {
        let chatLabel = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chatChannelLabel.text = "#" + chatLabel
        getMessages()
    }
    
    @objc func userDataDidChanged(_ notif : Notification) {
        if AuthService.instance.isLoggedin {
            onLoginGetMessages()
            messageTxtBox.isHidden = false
        } else {
            chatChannelLabel.text = "Please Log in"
            messageTable.reloadData()
            messageTxtBox.isHidden = true
        }
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTxtBox.text == "" {
            isTyping = false
            sendBtn.isHidden = true
        } else {
            if isTyping == false {
                sendBtn.isHidden = false
            }
            isTyping = true
        }
    }
    
    @IBAction func msgSendPressed(_ sender: Any) {
        if AuthService.instance.isLoggedin {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let messageBody = messageTxtBox.text else { return }
            
            SocketService.instance.addMessage(messageBody: messageBody, channelId: channelId) { (success) in
                if success {
                    self.messageTxtBox.text = nil
                    self.messageTxtBox.placeholderText = "message"
                }
            }
        }
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.chatChannelLabel.text = "No channels Yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelID: channelId) { (success) in
            if success {
                self.messageTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            
            let message = MessageService.instance.messages[indexPath.row]
            
            cell.configureCell(message: message)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }

}

