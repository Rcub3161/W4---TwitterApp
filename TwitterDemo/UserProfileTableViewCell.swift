//
//  UserProfileTableViewCell.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/26/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIView!
    @IBOutlet weak var nameLabel: UIView!
    @IBOutlet weak var timeStampLabel: UIView!
    @IBOutlet weak var tweetLabel: UIView!
    @IBOutlet weak var favoritesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var retweetsLabel: UILabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func retweetButton(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func favoriteButton(sender: AnyObject) {
        
        
    }

}
