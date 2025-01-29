
import UIKit

class SettingsViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var SettingTB: UITableView!
    @IBOutlet weak var vesion_Label: UILabel!

    @IBOutlet weak var MianView: UIView!

    var settingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingList = ["Home","Feedback","About app","Share App","Privacy Policy"]
        SettingTB.delegate = self
        SettingTB.dataSource = self
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "N/A"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] ?? "N/A"
        vesion_Label.text = "Version \(version) (\(build))"
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

    override func viewWillAppear(_ animated: Bool) {
    }
    func makeImageViewCircular(imageView: UIImageView) {
           // Ensure the UIImageView is square
           imageView.layer.cornerRadius = imageView.frame.size.width / 2
           imageView.clipsToBounds = true
       }

    private func NavToWelcome() {
        // Implement your data clearing logic here
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeSViewController") as! WelcomeSViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    
        private func clearUserData() {
            // Remove keys related to user data but not login information
            UserDefaults.standard.removeObject(forKey: "SavedVideos")
            UserDefaults.standard.removeObject(forKey: "dates")
            NavToWelcome()

     }

        private func showResetConfirmation() {
            let confirmationAlert = UIAlertController(title: "Success!", message: "Your data has been removed successfully.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            confirmationAlert.addAction(okAction)
            self.present(confirmationAlert, animated: true, completion: nil)
        }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SideMenuTableViewCell
        
        cell.sidemenu_label?.text = settingList[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeSViewController") as! WelcomeSViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
     
        else if indexPath.item == 1 {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.item == 2 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
       else if indexPath.item == 3 {
           let appID = "SnapSoulStudio"
           let appURL = URL(string: "https://apps.apple.com/app/id\(appID)")!
           let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
           present(activityViewController, animated: true, completion: nil)
            }
        else if indexPath.item == 4 {
           
            if let url = URL(string: "https://sites.google.com/view/privacypolicyappios/home") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
            
        }
 
    }
