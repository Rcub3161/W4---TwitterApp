//
//  TweetsTableViewCell.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/20/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    var tweet: Tweet! {
        didSet{
            /*profileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageURL)!)!)*/
            usernameLabel.text = tweet.user?.name as? String
            tweetTextLabel.text = tweet.text as? String
            timestampLabel.text = String(tweet.timestamp)
            retweetsLabel.text = "Retweets: \(String(tweet.retweet_count))"
            favoritesLabel.text = "Favorites: \(String(tweet.favoritesCount))"
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favButton(sender: AnyObject) {
    
    }
    @IBAction func retweetButton(sender: AnyObject) {
    
    }

}
