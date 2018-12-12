//
//  ChannelCell.swift
//  Dev-Chat App
//
//  Created by Ketan Choyal on 10/12/18.
//  Copyright © 2018 Ketan Choyal. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.25).cgColor
        }
        else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        
    }
    
    func configureCell(channel : Channel) {
        let title = channel.channelTitle ?? " "
        channelTitle.text = "#" + title
        
        channelTitle.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        if MessageService.instance.unreadChannels.contains(channel.id) {
            channelTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        }
        
    }

}
