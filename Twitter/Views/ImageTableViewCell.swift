//
//  ImageTableViewCell.swift
//  Twitter
//
//  Created by Ding, Quan on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var tweetBody: UILabel!
    @IBOutlet weak var tweetImage: UIImageView!

    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    var tweet:Tweet? {
        didSet {
            var user:User = tweet!.user!
            self.name.text = user.name!
            self.screenName.text = "@\(user.screenName!)"
            self.tweetBody.text = tweet!.text!
            self.tweetBody.preferredMaxLayoutWidth = self.tweetBody.frame.size.width
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
            ImageHelpers.roundedCorner(self.profileImage)
            ImageHelpers.roundedCorner(self.tweetImage)
            ImageHelpers.fadeInImage(self.profileImage, imgUrl: tweet?.user?.profileImageUrl)
            ImageHelpers.fadeInImage(self.tweetImage, imgUrl: tweet?.imageUrl)
        }
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
