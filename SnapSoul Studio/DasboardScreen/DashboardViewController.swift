//
//  DashboardViewController.swift
//  SnapSoul Studio
//
//  Created by ucf 2 on 01/01/2025.
//

import UIKit
import UIKit
import iOSPhotoEditor
import Photos
import ZLImageEditor
class DashboardViewController: UIViewController {
        @IBOutlet weak var MianView: UIView!
        @IBOutlet weak var CollectionView: UICollectionView!
    var isColorPhotoEditor = false
    var isCustomPhotorEditor = false
    var resultImageEditModel: ZLEditImageModel?

    
    //        var orderDetails: [ordersBooking] = []
            var type = [String]()
            var Imgs: [UIImage] = [
                UIImage(named: "2")!,
                UIImage(named: "4")!,
                UIImage(named: "3")!,
                UIImage(named: "5")!,
                UIImage(named: "6")!,
                UIImage(named: "7")!]

            override func viewDidLoad() {
                super.viewDidLoad()
                
                type = [
                "Background Magic",
                "Snap Collage",
                "ColorPop Editor",
                "Video Cutter",
                "Custom Photo Editor",
                "App Setting",
//
                ]
                CollectionView.dataSource = self
                CollectionView.delegate = self
                CollectionView.collectionViewLayout = UICollectionViewFlowLayout()
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


        }
    extension DashboardViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return type.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DashbordCollectionViewCell
            
            cell.Label.text = type [indexPath.item]
            cell.images.image? =  Imgs [indexPath.item]
            
            return cell
            
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            let spacing: CGFloat = 12
            let availableWidth = collectionViewWidth - (spacing * 3)
            let width = availableWidth / 2
            let height = width * 0.8 // Adjust this multiplier to control the height
            return CGSize(width: width + 3, height: height)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10 // Adjust as needed
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 9, bottom: 20, right: 9) // Adjust as needed
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            
//            
                        if indexPath.row == 0
                        {
            
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BgRemovalViewController") as! BgRemovalViewController
            
                            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                            newViewController.modalTransitionStyle = .crossDissolve
                            self.present(newViewController, animated: true, completion: nil)
            
                        }
//            
                        if indexPath.row == 1
                        {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectLayoutcollageViewController") as! SelectLayoutcollageViewController
            
                            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                            newViewController.modalTransitionStyle = .crossDissolve
                           self.present(newViewController, animated: true, completion: nil)
            
                        }
                        if indexPath.row == 2
                        {
                            isColorPhotoEditor = true
                            isCustomPhotorEditor = false
                            showStyleSheet()

                        }
                        if indexPath.row == 3
                        {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "VideoCropperViewController") as! VideoCropperViewController
                            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                            newViewController.modalTransitionStyle = .crossDissolve
                            self.present(newViewController, animated: true, completion: nil)
                        }
////            
                        if indexPath.row == 4
                        {
                            isColorPhotoEditor = false
                            isCustomPhotorEditor = true
                            showStyleSheet()   
                        }
            if indexPath.row == 5
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                newViewController.modalTransitionStyle = .crossDissolve
                self.present(newViewController, animated: true, completion: nil)
            }
//
//            
                 }
        
        }
extension DashboardViewController :UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    

 

    func showStyleSheet()
    {
        let styleSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Select from Camera", style: .default) { [weak self] _ in
            self?.openCamera()
        }
        
        let galleryAction = UIAlertAction(title: "Open from Gallery", style: .default) { [weak self] _ in
            self?.chooseImageFromGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        styleSheet.addAction(cameraAction)
        styleSheet.addAction(galleryAction)
        styleSheet.addAction(cancelAction)
        
        present(styleSheet, animated: true, completion: nil)
    }

    func openCamera()
   {
       let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
       
       switch cameraAuthorizationStatus {
       case .authorized:
        DispatchQueue.main.async { [weak self] in
               self?.presentCamera()
        }
       case .notDetermined:
           AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
               DispatchQueue.main.async {
                   if granted {
                       self?.presentCamera()
                   } else {
                       self?.redirectToSettings()
                   }
               }
           }
       case .denied, .restricted:
           redirectToSettings()
       @unknown default:
           break
       }
   }
    private func presentCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(
                title: "Camera Not Available",
                message: "Please check your settings to enable the camera.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    
    private func redirectToSettings()
    {
        let alertController = UIAlertController(title: "Permission Required", message: "Please enable access to the camera or photo library.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func chooseImageFromGallery() {
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
           activityIndicator.center = view.center
           activityIndicator.startAnimating()
           view.addSubview(activityIndicator)
        
        let photoLibraryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoLibraryAuthorizationStatus {
        case .authorized:
            DispatchQueue.main.async { [weak self] in
                self?.presentImagePicker(with: activityIndicator)
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                DispatchQueue.main.async
                {
                    if status == .authorized
                    {
                        self?.presentImagePicker(with: activityIndicator)
                    } else {
                        self?.redirectToSettings()
                    }
                }
            }
        case .denied, .restricted:
            redirectToSettings()
        case .limited:
            // Handle limited photo library access if needed
            break
        @unknown default:
            break
        }
    }
    
    private func presentImagePicker(with activityIndicator: UIActivityIndicatorView) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true) {
            // Dismiss the activity indicator once the gallery is presented
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        // Directly access the image without optional binding since it's guaranteed to be UIImage
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        // Proceed with image editing based on the selection
        if self.isColorPhotoEditor {
            self.openiOSPhotoEditor(with: image)
        } else if self.isCustomPhotorEditor {
            self.openZLPhotoEditor(image, editModel: nil)
        }
    }
    func openZLPhotoEditor(_ image: UIImage, editModel: ZLEditImageModel?) {
            ZLEditImageViewController.showEditImageVC(parentVC: self, image: image, editModel: editModel) { [weak self] editedImage, editModel in
                if editedImage != nil {
                    self?.resultImageEditModel = editModel

                    // Save the edited image to the photo library
                    UIImageWriteToSavedPhotosAlbum(editedImage, nil, nil, nil)

                    // Optionally, display an alert to inform the user that the image has been saved
                    let alert = UIAlertController(title: "Saved!", message: "Your edited image has been successfully saved.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    // Handle the case where editedImage is nil
                }
            }
        }

    
            
            
    
    func openiOSPhotoEditor(with image: UIImage) {
        let photoEditor = PhotoEditorViewController(nibName: "PhotoEditorViewController", bundle: Bundle(for: PhotoEditorViewController.self))
        photoEditor.image = image
        
        for i in 0...10 {
            if let sticker = UIImage(named: "\(i)") {
                photoEditor.stickers.append(sticker)
            }
        }
        photoEditor.modalPresentationStyle = .fullScreen
        present(photoEditor, animated: true, completion: nil)
    }

    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}



