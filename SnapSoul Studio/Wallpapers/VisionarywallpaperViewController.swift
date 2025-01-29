//
//  VisionarywallpaperViewController.swift
//  SnapSoul Studio
//
//  Created by UCF 2 on 02/01/2025.
//

import UIKit

class VisionarywallpaperViewController: UIViewController  {
    
    @IBOutlet weak var wallpaperCollectionView: UICollectionView!
    @IBOutlet weak var MianView: UIView!

    
    let imagesList = ["1.1","1.2","1.3","1.4","1.5","1.6","1.7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wallpaperCollectionView.dataSource = self
        wallpaperCollectionView.delegate = self
        wallpaperCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
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
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
extension VisionarywallpaperViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VisionaryWallsCollectionViewCell
        cell.Imgs.image = UIImage(named: imagesList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 10
        let availableWidth = collectionViewWidth - (spacing * 3)
        let width = availableWidth / 2
        return CGSize(width: width - 20, height: width + 20)
      // return CGSize(width: wallpaperCollectionView.frame.size.width , height: wallpaperCollectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right:20) // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
      // let item = imagesList [indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "DetailvisionaryWallpaperVCViewController")
        as! DetailvisionaryWallpaperVCViewController
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.selectedImage = UIImage(named: imagesList[indexPath.item])
        self.present(secondVC, animated: true)
        
    }
}

