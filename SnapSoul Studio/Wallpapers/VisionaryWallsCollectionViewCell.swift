//
//  VisionaryWallsCollectionViewCell.swift
//  SnapSoul Studio
//
//  Created by UCF 2 on 02/01/2025.
//

import UIKit

class VisionaryWallsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cview: UIView!
    @IBOutlet weak var Imgs: UIImageView!

     override func awakeFromNib() {
         super.awakeFromNib()
    
         cview.layer.cornerRadius = 15
        
    // Set up shadow properties
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 2)
      layer.shadowOpacity = 0.3
      layer.shadowRadius = 4.0
      layer.masksToBounds = false

      // Set background opacity
        contentView.alpha = 1.5 // Adjust opacity as needed

}
}
