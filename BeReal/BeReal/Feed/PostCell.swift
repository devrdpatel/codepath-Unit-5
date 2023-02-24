//
//  PostCell.swift
//  BeReal
//
//  Created by Dev Patel on 2/18/23.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {

    var imageDataRequest: DataRequest?
    var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var feedCaption: UILabel!
    @IBOutlet weak var feedPostDate: UILabel!
    @IBOutlet weak var blurImageView: UIVisualEffectView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    func configure(with post: Post) {
        // Set username
        if let user = post.user {
            usernameLabel.text = user.username
        }
        
        // Image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage to help fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.feedImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }
        
        // Caption
        feedCaption.text = post.caption
        
        // Post Date
        if let date = post.createdAt {
            feedPostDate.text = DateFormatter.postFormatter.string(from: date)
        }
        
        // Blur View
        visualEffectView.frame = feedImageView.bounds
        
        if let currentUser = User.current,

            // Get the date the user last shared a post (cast to Date).
           let lastPostedDate = currentUser.lastPostedDate,

            // Get the date the given post was created.
           let postCreatedDate = post.createdAt,
            
            // Get the difference in hours between when the given post was created and the current user last posted.
           let diffHours = Calendar.current.dateComponents([.hour], from: lastPostedDate, to: Date()).hour {

            // Hide the blur view if the given post was created within 24 hours of the current user's last post. (before or after)
            //blurImageView.isHidden = abs(diffHours) < 24
            visualEffectView.isHidden = abs(diffHours) < 24
        } else {

            // Default to blur if we can't get or compute the date's above for some reason.
            //blurImageView.isHidden = false
            //blurImageView.bringSubviewToFront(blurImageView.contentView)
            //feedImageView.isHidden = true
            visualEffectView.isHidden = false
        }
        feedImageView.addSubview(visualEffectView)
    }
    
    // Cancel Image load if cell goes out of view
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset image view
        feedImageView.image = nil
        
        // Cancel image request
        imageDataRequest?.cancel()
    }

}
