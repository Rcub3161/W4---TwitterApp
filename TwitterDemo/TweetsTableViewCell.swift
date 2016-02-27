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
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweetID: Int!
    
    var tweet: Tweet! {
        didSet{
            userProfileImage.setImageWithURL(NSURL(string: (tweet.user?.newImageUrl)!)!)
            usernameLabel.text = tweet.user?.name as? String
            tweetTextLabel.text = tweet.text as? String
            timestampLabel.text = String(tweet.timestamp!)
            retweetsLabel.text = "Retweets: \(String(tweet.retweet_count))"
            favoritesLabel.text = "Favorites: \(String(tweet.favoritesCount))"
            tweetID = tweet.id
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userProfileImage.layer.cornerRadius = 3
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: "imageViewTapped")
        userProfileImage.addGestureRecognizer(tapGestureRecognizer)
        // Initialization code
    }
    
    func imageViewTapped() {
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favButton(sender: AnyObject) {
        if(tweet.favorited == true){
            TwitterClient.sharedInstance.unfavorite(tweetID)
            favoritesLabel.text = "Favorites: \(String(tweet.favoritesCount))"
            tweet.favorited = false
            return;
        }
        else{
            tweet.favorited = true
            TwitterClient.sharedInstance.favorite(tweetID)
            favoritesLabel.text = "Favorites: \(String(tweet.favoritesCount))"
            print("can't favorite")
        }
    }
    @IBAction func retweetButton(sender: AnyObject) {
        print("retweeted")
        if(tweet.retweeted == true){
            TwitterClient.sharedInstance.untweet(tweetID)
            tweet.retweet_count--
            retweetsLabel.text = "Retweets: \(String(tweet.retweet_count))"
            tweet.retweeted = false
            return;
        }
        else{
            tweet.retweeted = true
            TwitterClient.sharedInstance.retweet(tweetID)
            tweet.retweet_count++
            retweetsLabel.text = "Retweets: \(String(tweet.retweet_count))"
        }
    }
    
    

}
