//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/20/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    var tweets: [Tweet]!
    
    var temp: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    var selection: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            for tweet in tweets {
                print(tweet.text)
            }
            }, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
        })

    }
    

    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? TweetsTableViewCell

        cell!.tweet = tweets[indexPath.row]
        cell!.selectionStyle = .None
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: "imageViewTapped:")
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        cell!.userProfileImage.addGestureRecognizer(tapGestureRecognizer)
        cell!.userProfileImage.userInteractionEnabled = true
        //selection = tweets![indexPath.row]
        cell!.userProfileImage.tag = indexPath.row
        

        
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
    
    func imageViewTapped(sender: AnyObject) {
        print("image tapped")
        let tapView = sender.view as? UIImageView
        temp = tapView!.tag
        selection = tweets![temp]
        
        self.performSegueWithIdentifier("userProfileSegue", sender: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func refreshAction(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
        refreshControl.endRefreshing()
        })
        refreshControl.endRefreshing()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let move = segue.destinationViewController
        
        if let move = move as? UserProfileViewController {
            move.user = selection.user
        }
        
    }


}
