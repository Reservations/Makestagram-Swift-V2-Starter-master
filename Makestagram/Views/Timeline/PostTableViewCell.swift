//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Kha Nguyen on 6/28/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var likesIconImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
    }
    @IBAction func likeButtonTapped(sender: AnyObject) {
        post?.toggleLikePost(PFUser.currentUser()!)
    }
	
	var postDisposable: DisposableType?
	var likeDisposable: DisposableType?
    
    var post: Post? {
		
        didSet {
			
			postDisposable?.dispose()
			likeDisposable?.dispose()
			
			if let post =  post {
				postDisposable = post.image.bindTo(postImageView.bnd_image)
				likeDisposable = post.likes.observe { (value: [PFUser]?) -> () in // code in closure executed everytime post.likes changes
					
					if let value = value {
						self.likesLabel.text = self.stringFromUserList(value)
						self.likeButton.selected = value.contains(PFUser.currentUser()!)
						self.likesIconImageView.hidden = (value.count == 0)
					}
						
					else {
						self.likesLabel.text = ""
						self.likeButton.selected = false
						self.likesIconImageView.hidden = true
					}
				}
			eve
		}
	}
	
	func stringFromUserList(userList: [PFUser]) -> String {
		let usernameList = userList.map { user in user.username! }
		let commaSeparatedList = usernameList.joinWithSeparator(",")
		return commaSeparatedList
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
