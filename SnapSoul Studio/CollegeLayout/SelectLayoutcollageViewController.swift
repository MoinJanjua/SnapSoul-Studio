//
//  SelectLayoutcollageViewController.swift
//  SnapSoul Studio
//
//  Created by UCF 2 on 03/01/2025.
//

import UIKit



class SelectLayoutcollageViewController: UIViewController {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var MianView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        CollectionView.dataSource = self
        CollectionView.delegate = self
        applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 30)

    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
        

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

extension SelectLayoutcollageViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return layoutImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayoutCell", for: indexPath) as! SelectlayoutCollectionViewCell
        
//        cell.Meds_labelNames.text = isSearching ? filteredData[indexPath.item] : MedicineName[indexPath.item]
        cell.Imgs.image? = layoutImages[indexPath.item]
        
        return cell
  
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            let spacing: CGFloat = 10
            let availableWidth = collectionViewWidth - (spacing * 3)
            let width = availableWidth / 4
            return CGSize(width: width - 10, height: width + 20)
        }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10 // Adjust as needed
    //    }
    //
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30) // Adjust as needed
        }
        
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 110, height: 110)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Item at index \(indexPath.item) selected")
//        let item = isSearching ? filteredData[indexPath.item] : MedicineName[indexPath.item]
        let item = layoutImages [indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let secondVC = storyboard.instantiateViewController(withIdentifier: "CollageSetViewController")
          as! CollageSetViewController
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.indexPath = indexPath.item
        self.present(secondVC, animated: true)
        
  }

}

