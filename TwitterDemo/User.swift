//
//  User.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/20/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenname: String?
    var newImageUrl: String?
    var profileUrl: NSURL?
    var tagline: NSString?
    var backgroundImageUrl: String?
    
    var dictionary: NSDictionary?
    
    var tweetCount: Int?
    var followersCount: Int?
    var followingCount: Int?
    
    init(dictionary: NSDictionary) {

        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        newImageUrl = dictionary["profile_image_url_https"] as? String
        backgroundImageUrl = dictionary["profile_background_image_url"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
        
    }
    static let userDidLogoutNotification = "userDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User?{
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                
                let userData = defaults.objectForKey("currentUserData") as? NSData
            
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
        
            }
            
            return _currentUser
    }
        set(user){
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
                //user.dictionary
            } else{
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
    
}
