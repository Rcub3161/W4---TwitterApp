//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/28/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var tweet:  Tweet!
    var tweetID: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        realNameLabel.text = tweet.user?.name
        usernameLabel.text = tweet.user?.screenname
        profileImage.setImageWithURL(NSURL(string: (tweet.user?.newImageUrl)!)!)
        tweetLabel.text = tweet.text as? String
        //timestampLabel.text = String(tweet.timestamp!)
        retweetsCountLabel.text = "Retweets: \(String(tweet.retweet_count))"
        favoritesCountLabel.text = "Favorites: \(String(tweet.favoritesCount))"
        tweetID = tweet.id
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func retweetButton(sender: AnyObject) {
        if(tweet.retweeted == true){
            TwitterClient.sharedInstance.untweet(tweetID)
            tweet.retweet_count--
            retweetsCountLabel.text = "Retweets: \(String(tweet.retweet_count))"
            tweet.retweeted = false
            return;
        }
        else{
            tweet.retweeted = true
            TwitterClient.sharedInstance.retweet(tweetID)
            tweet.retweet_count++
            retweetsCountLabel.text = "Retweets: \(String(tweet.retweet_count))"
        }

    
    }
    @IBAction func favoriteButton(sender: AnyObject) {
        if(tweet.favorited == true){
            TwitterClient.sharedInstance.unfavorite(tweetID)
            favoritesCountLabel.text = "Favorites: \(String(tweet.favoritesCount))"
            tweet.favorited = false
            return;
        }
        else{
            tweet.favorited = true
            TwitterClient.sharedInstance.favorite(tweetID)
            favoritesCountLabel.text = "Favorites: \(String(tweet.favoritesCount))"
            print("can't favorite")
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
