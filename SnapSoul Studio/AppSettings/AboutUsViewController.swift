
import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var feedbackTV:UITextView!
    @IBOutlet weak var MianView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackTV.layer.borderWidth = 1.0
        feedbackTV.layer.borderColor = UIColor.white.cgColor
        feedbackTV.layer.cornerRadius = 10.0
        feedbackTV.clipsToBounds = true
        applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 30)
        // Do any additional setup after loading the view.
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

    
    @IBAction func backbtnPressed(_ sender:UIButton)
    {
        self.dismiss(animated: true)
    }
}
