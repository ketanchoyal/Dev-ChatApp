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
        
        //2018-12-10T20:36:14.732Z
        
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let timeStamp = newFormatter.string(from: finalDate)
            timeStampLbl.text = timeStamp
        }
        
    }

}
