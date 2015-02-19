//
//  TextTableViewCell.swift
//  Twitter
//
//  Created by Ding, Quan on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var tweetBody: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!

    var tweet:Tweet? {
        didSet {
            var user:User = tweet!.user!
            self.name.text = user.name!
            self.screenName.text = "@\(user.screenName!)"
            self.tweetBody.text = tweet!.text!
            self.tweetBody.sizeToFit()
            self.favoriteCount.text = "\(tweet!.favoriteCount!)"
            self.favoriteCount.sizeToFit()
            self.retweetCount.text = "\(tweet!.retweetCount!)"
            self.retweetCount.sizeToFit()
            self.createdAt.text = tweet!.createdAt!.shortTimeAgoSinceNow()
            self.createdAt.sizeToFit()
            if tweet!.favorited! {
                self.favoriteIcon.image = UIImage(named: "favorite_on")
            } else {
                self.favoriteIcon.image = UIImage(named: "favorite")
            }
            self.profileImage.layer.cornerRadius = 5
            self.profileImage.clipsToBounds = true
            
            fadeInImage(self.profileImage, imgUrl: tweet?.user?.profileImageUrl)
        }
    }
    
    private func fadeInImage(imageView: UIImageView, imgUrl: String?) -> Void {
        imageView.image = nil
        var urlReq = NSURLRequest(URL: NSURL(string: imgUrl!)!)
        imageView.setImageWithURLRequest(urlReq, placeholderImage: nil, success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image:UIImage!) -> Void in
            imageView.alpha = 0.0
            imageView.image = image
            UIView.animateWithDuration(0.25, animations: { imageView.alpha = 1.0})
            }, failure: { (request:NSURLRequest!, response:NSHTTPURLResponse!, error:NSError!) -> Void in
                println(error)
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
