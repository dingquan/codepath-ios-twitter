//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Ding, Quan on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

private let placeHolderText = "What's happing?"

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetBody: UITextView!
    
    
    @IBAction func onTweet(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetBody.delegate = self
        tweetBody.text = placeHolderText
        tweetBody.textColor = UIColor.grayColor()
        
        if User.currentUser != nil {
            name.text = User.currentUser!.name
            screenName.text = User.currentUser!.screenName
            ImageHelpers.roundedCorner(profileImage)
            ImageHelpers.fadeInImage(profileImage, imgUrl: User.currentUser!.profileImageUrl)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        tweetBody.textColor = UIColor.blackColor()
        
        if(self.tweetBody.text == placeHolderText) {
            self.tweetBody.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text == "") {
            tweetBody.text = placeHolderText
            tweetBody.textColor = UIColor.lightGrayColor()
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
