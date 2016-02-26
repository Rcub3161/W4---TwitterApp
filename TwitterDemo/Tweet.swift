//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Ryan Linehan on 2/20/16.
//  Copyright © 2016 Ryan Linehan. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: NSString?
    var timestamp: NSDate?
    var retweet_count: Int = 0
    var favoritesCount: Int = 0
    var favorited: Bool?
    var retweeted: Bool?
    var user: User?
    var id: Int!
    var retweeted_status: Tweet?
    
    init(dictionary: NSDictionary)
    {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweet_count = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        id = dictionary["id"] as! Int
        favorited = (dictionary["favorited"]) as? Bool
        retweeted = (dictionary["retweeted"]) as? Bool
        let timeStampString = dictionary["created_at"] as? String

        
        if let retweeted_tweet = dictionary["retweeted_status"] as? NSDictionary {
            retweeted_status = Tweet.init(dictionary: retweeted_tweet)
        }
        
        if let timeStampString = timeStampString {
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timeStampString)
        }
     
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
        
    }
    
}
