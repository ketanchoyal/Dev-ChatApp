//
//  MessageCell.swift
//  Dev-Chat App
//
//  Created by Ketan Choyal on 12/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userProfileImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message : Message) {
        userNameLbl.text = message.userName
        messageBodyLbl.text = message.message
        userProfileImg.image = UIImage(named: message.userAvatar)
        userProfileImg.backgroundColor = UserDataService.instance.returnUIColor(component: message.userAvatarColor)
    }

}
