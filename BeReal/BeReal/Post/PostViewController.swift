//
//  PostViewController.swift
//  BeReal
//
//  Created by Dev Patel on 2/18/23.
//

import UIKit
import PhotosUI
import ParseSwift

class PostViewController: UIViewController {
    
    var pickedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBAction func selectPhotosTapped(_ sender: Any) {
        // Also add Usage - Photo Privacy Description key to info.plst
        var config = PHPickerConfiguration()
        
        config.filter = .images
        
        config.preferredAssetRepresentationMode = .current
        
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = self
        
        present(picker, animated:  true)
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        // Dismiss Keyboard
        view.endEditing(true)

        // TODO: Pt 1 - Create and save Post
        // Unwrap optional pickedImage
        guard let image = pickedImage,
              // Create and compress image data (jpeg) from UIImage
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }

        // Creatae a Parse File by providing a name and passing in the image data
        let imageFile = ParseFile(name: "image.jpg", data: imageData)

        // Create Post object
        var post = Post()
        
        // Set properties
        post.imageFile = imageFile
        post.caption = captionField.text

        // Set the user as the current user
        post.user = User.current

        // Save object in background (async)
        post.save { [weak self] result in

            // Switch to the main thread for any UI updates
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    print("✅ Post Saved! \(post)")

                    // Return to previous view controller
                    self?.navigationController?.popViewController(animated: true)

                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
    }
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else {
            return
        }

        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            guard let image = object as? UIImage else {
                self?.showAlert()
                return
            }
            
            if let error = error {
                self?.showAlert(description: error.localizedDescription)
                return
            } else {
                DispatchQueue.main.async {
                    self?.postImageView.image = image
                    
                    self?.pickedImage = image
                }
            }
        }
    }
}
