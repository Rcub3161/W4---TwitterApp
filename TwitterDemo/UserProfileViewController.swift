//
//  UserProfileViewController.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/25/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: User!
    var tweets: [Tweet]!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var extraUsernameLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    var userID: Int!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        fullNameLabel.text = user.name
        extraUsernameLabel.text = user.screenname
        profileImage.setImageWithURL(NSURL(string: user.newImageUrl!)!)
        backgroundImage.setImageWithURL(NSURL(string: user.backgroundImageUrl!)!)
        numberTweetsLabel.text = String(user.tweetCount!)
        followingLabel.text = String(user.followingCount!)
        followersLabel.text = String(user.followersCount!)
        userID = user.userID
        if(user.userID != nil) {
        TwitterClient.sharedInstance.userTimeLine ((user.userID)!,
             success: {(tweets: [Tweet]) -> () in
             self.tweets = tweets
             self.tableView.reloadData()
             }, failure: {(error: NSError) -> () in
                 print(error.localizedDescription)
         })
        }
        //print(tweets)
        print("UserID: \(userID)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if (user.userID != nil) {
            TwitterClient.sharedInstance.userTimeLine ((user.userID)!,
                success: {(tweets: [Tweet]) -> () in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: {(error: NSError) -> () in
                    print(error.localizedDescription)
            })
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as? TweetsTableViewCell
        
        cell!.tweet = tweets[indexPath.row]
        cell!.selectionStyle = .None
    
        return cell!
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return(self.tweets.count)
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
