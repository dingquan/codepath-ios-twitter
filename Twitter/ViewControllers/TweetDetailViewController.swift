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
    @IBOutlet weak var favoriteIcon: UIImageView!

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
                self.favoriteIcon.image = UIImage(named: "favorite_on")
            } else {
                self.favoriteIcon.image = UIImage(named: "favorite")
            }
            
            ImageHelpers.roundedCorner(self.profileImage)
            ImageHelpers.roundedCorner(self.tweetImage)
            ImageHelpers.fadeInImage(self.profileImage, imgUrl: tweet.user?.profileImageUrl)
            if tweet.imageUrl != nil{
                ImageHelpers.fadeInImage(self.tweetImage, imgUrl: tweet.imageUrl!)
            }
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
