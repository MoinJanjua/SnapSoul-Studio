//
//  WelcomeSViewController.swift
//  SnapSoul Studio
//
//  Created by ucf 2 on 01/01/2025.
//

import UIKit

class WelcomeSViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton! // Connect your button here

    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply gradient to the button
        applyGradientToButton()
    }

    @IBAction func startbtn(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }

    func applyGradientToButton() {
        // Ensure the button is not nil
        guard let button = startButton else { return }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [
            UIColor.systemBlue.cgColor,  // Start color
            UIColor.systemPurple.cgColor // End color
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = button.layer.cornerRadius

        // Ensure existing gradient layers are removed to avoid stacking
        button.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        // Add the gradient layer to the button
        button.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Update the gradient frame after layout changes
        applyGradientToButton()
    }
}
