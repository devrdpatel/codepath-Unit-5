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
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var feedCaption: UILabel!
    @IBOutlet weak var feedPostDate: UILabel!
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
