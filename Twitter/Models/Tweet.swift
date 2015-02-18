//
//  Tweet.swift
//  Twitter
//
//  Created by Ding, Quan on 2/17/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class Tweet {
    var text:String?
    var createdAt:NSDate?
    var user:User?
    
    init(dictionary: NSDictionary){
        self.text = dictionary["text"] as? String
        self.user = User(dictionary: dictionary["user"] as! NSDictionary)
        var createdAtStr = dictionary["created_at"] as? String
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.createdAt = dateFormatter.dateFromString(createdAtStr!)
    }
    
    class func tweetsWithArray(array:[NSDictionary]) -> [Tweet] {
        var tweets:[Tweet] = [Tweet]()
        
        for dictionary in array {
            var tweet:Tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}