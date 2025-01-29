//
//  DetailvisionaryWallpaperVCViewController.swift
//  SnapSoul Studio
//
//  Created by UCF 2 on 02/01/2025.
//

import UIKit

class DetailvisionaryWallpaperVCViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var MianView: UIView!

    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = selectedImage
        applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 30)

    }
    
func applyCornerRadiusToBottomCorners(view: UIView, cornerRadius: CGFloat) {
   // Ensure the layout has been updated before applying the corner radius
   view.layoutIfNeeded()

   // Create a rounded path for only the bottom-left and bottom-right corners
   let path = UIBezierPath(roundedRect: view.bounds,
                           byRoundingCorners: [.bottomLeft, .bottomRight],
                           cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
   
   let mask = CAShapeLayer()
   mask.path = path.cgPath
   view.layer.mask = mask
}
    func saveImageToPhotoLibrary(_ image: UIImage) {
           UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
       }
       
       // Completion handler to handle success or failure
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
           if let error = error {
               // If an error occurs, print it or show an alert
               print("Error in saving image: \(error.localizedDescription)")
               showAlert(title: "Save error", message: error.localizedDescription)
           } else {
               // Notify the user that the save was successful
               print("Your Image saved successfully!")
               showAlert(title: "Saved!", message: "Your image has been saved to your gallery.")
           }
       }
       
    @IBAction func DownloadWpButton(_ sender: Any) {
        
        // Check if there is an image to download
               guard let image = selectedImage else {
                   print("No image found, pleae add some images!")
                   return
               }
               
               // Save the image to the photo library
               saveImageToPhotoLibrary(image)
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
