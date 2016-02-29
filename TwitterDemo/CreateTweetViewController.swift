//
//  CreateTweetViewController.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/28/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createTweetView: UITextView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTweetView.delegate = self
        realNameLabel.text = user?.name
        usernameLabel.text = user?.screenname
        profileImage.setImageWithURL(NSURL(string: (user?.newImageUrl)!)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tweetButton(sender: AnyObject) {
    
        TwitterClient.sharedInstance.tweet(createTweetView.text)
        dismissViewControllerAnimated(true) { () -> Void in
        }
    
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
   
     dismissViewControllerAnimated(true) { () -> Void in
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
