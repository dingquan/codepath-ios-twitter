//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Ding, Quan on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetBody: UILabel!
    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var retweetCnt: UILabel!
    @IBOutlet weak var favoriteCnt: UILabel!
    @IBOutlet weak var favoriteIcon: UIButton!
    @IBOutlet weak var replyIcon: UIButton!
    @IBOutlet weak var retweetIcon: UIButton!

    var tweet:Tweet?
    var dateFormatter:NSDateFormatter!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "m/dd/yy, hh:mm a"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        loadTweet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadTweet() -> Void {
        if let tweet = tweet {
            name.text = tweet.user!.name
            screenName.text = "@\(tweet.user!.screenName!)"
            tweetBody.text = tweet.text!
            tweetBody.preferredMaxLayoutWidth = tweetBody.frame.size.width
            tweetBody.sizeToFit()
            favoriteCnt.text = "\(tweet.favoriteCount!)"
            favoriteCnt.sizeToFit()
            retweetCnt.text = "\(tweet.retweetCount!)"
            retweetCnt.sizeToFit()
            createdAt.text = dateFormatter.stringFromDate(tweet.createdAt!)
            
            if tweet.favorited! {
                self.favoriteIcon.setImage(UIImage(named: "favorite_on"), forState: UIControlState.Normal)
            } else {
                self.favoriteIcon.setImage(UIImage(named: "favorite"), forState: UIControlState.Normal)
            }
            
            if tweet.retweeted! {
                self.retweetIcon.setImage(UIImage(named: "retweet_on"), forState: UIControlState.Normal)
            } else {
                self.retweetIcon.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            }
            
            ImageHelpers.roundedCorner(self.profileImage)
            ImageHelpers.roundedCorner(self.tweetImage)
            ImageHelpers.fadeInImage(self.profileImage, imgUrl: tweet.user?.profileImageUrl)
            if tweet.imageUrl != nil{
                ImageHelpers.fadeInImage(self.tweetImage, imgUrl: tweet.imageUrl!)
            }
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if (self.tweet?.retweeted! == true) {
            return // can only retweet once
        }
        
        User.currentUser?.reTweetWithCompletion(self.tweet!.id!, completion: { (tweet, error) -> Void in
            if (tweet != nil) {
                self.tweet = tweet!
                self.retweetCnt.text = "\(tweet!.retweetCount!)"
                self.retweetCnt.sizeToFit()
                self.retweetIcon.setImage(UIImage(named: "retweet_on"), forState: UIControlState.Normal)
            }
            else {
                println(error)
            }
        })
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        if (tweet!.favorited! == true) {
            User.currentUser?.unfavoriteTweetWithCompletion(self.tweet!.id!, completion: { (tweet, error) -> Void in
                if (tweet != nil) {
                    self.tweet = tweet!
                    self.favoriteIcon.setImage(UIImage(named: "favorite"), forState: UIControlState.Normal)
                    self.favoriteCnt.text = "\(tweet!.favoriteCount!)"
                    self.favoriteCnt.sizeToFit()
                } else {
                    println(error)
                }
            })
        } else {
            User.currentUser?.favoriteTweetWithCompletion(self.tweet!.id!, completion: { (tweet, error) -> Void in
                if (tweet != nil) {
                    self.tweet = tweet!
                    self.favoriteIcon.setImage(UIImage(named: "favorite_on"), forState: UIControlState.Normal)
                    self.favoriteCnt.text = "\(tweet!.favoriteCount!)"
                    self.favoriteCnt.sizeToFit()
                } else {
                    println(error)
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "replyTweetFromDetailsView" {
            let newTweetVC = segue.destinationViewController as! NewTweetViewController
            newTweetVC.inReplyToTweet = self.tweet
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
