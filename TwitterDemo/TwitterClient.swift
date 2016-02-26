//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/20/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {


    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "u3oAwJVSAubYgf5aGJquVywoL", consumerSecret: "rxSZBbwpHaZD7Bs1ygnf8slLMoYEcEWNgNuVRD2GkgXKBLLusp")
    
    var loginSuccess: (() ->())?
    var loginFailure: ((NSError) ->())?
    
    
    func login(success: () -> (),failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL)
    {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: {(error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
            }) {(error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }

    }
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }

    func retweet(id: Int) {
        POST("//api.twitter.com/1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation, response) -> Void in
            print("success")
            
            }, failure: { (operation, error) -> Void in
                print("error")
        })
    }
    func untweet(id: Int) {
        POST("1.1/statuses/unretweet/\(id).json", parameters: nil,  success: { (operation, response) -> Void in
            print("succesfully untweeted")
            }, failure: { (operation, error) -> Void in
                print("error doing this")
        })
    }
    
    func favorite(id: Int) {
        POST("https://api.twitter.com/1.1/favorites/create.json", parameters: ["id": id], success: { (operation, response) -> Void in
            print("favorited")
            
            }, failure: { (operation, error) -> Void in
                print("error")
        })
    }
    
    func unfavorite(id: Int) {
        POST("https://api.twitter.com/1.1/favorites/destroy.json", parameters: ["id": id], success: { (operation, response) -> Void in
            print("unfavorited")
            }, failure: { (operation, error) -> Void in
                print("error")
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            
            
            //print("user: \(user)")
            

            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url:\(user.profileUrl)")
            print("description: \(user.tagline)")
            
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })

    }

}
