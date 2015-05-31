import UIKit
import Parse

class SignUpVC: UIViewController {
    
    // Properties
    var fbID:String?
    var gender:String?
    
    @IBOutlet weak var profilePicIV: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBAction func switchedGender(sender: AnyObject) {
        if genderSwitch!.on {
//            println("female")
            self.gender = "female"
            self.maleLabel!.alpha = 0.3
            self.femaleLabel!.alpha = 1
        } else {
//            println("male")
            self.gender = "male"
            self.femaleLabel!.alpha = 0.3
            self.maleLabel!.alpha = 1
        }
    }
    @IBAction func signUpButton(sender: AnyObject) {
        // Send to Parse
        if let user = PFUser.currentUser() {
            var imageData:NSData = UIImagePNGRepresentation(profilePicIV.image)
            var imagePFFile:PFFile = PFFile(name: "Profile Picture", data: imageData)
            user["profilePic"] = imagePFFile
            user["fullname"] = nameTextField.text
            user["age"] = (ageTextField.text)
            user.email = emailTextField.text
            user["gender"] = gender
            user["fbID"] = fbID
            user.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError?) -> Void in
                if (succeeded == true) {
                    // The object has been saved.
                    println("Info saved to Parse.")
                    // Present next View Controller
                    self.presentViewController(MainVC(), animated: true, completion: nil)
                    
                } else {
                    // There was a problem, check error.
                    println("\(error?.description)")
                    let alertView = UIAlertView(title: "Oops somethings wrong", message: "Please try signing up again. Thank you", delegate: self, cancelButtonTitle: "Try Again")
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fill Fields with Facebook Info
        fbGraphRequest()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Tap Recognizer to quit editting mode
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    // Facebook Graph Request
    func fbGraphRequest() {
        let graphUrl = "me?fields=id,name,gender,email,picture.type(square).width(300).height(300)"
        let fbGraphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: graphUrl, parameters: nil)
        fbGraphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            // Set textfields
            if let fbResult:AnyObject = result {
//                println("\(fbResult)")
                self.emailTextField.text  = fbResult["email"] as? String
                self.fbID   = fbResult["id"] as? String
                self.nameTextField.text   = fbResult["name"] as? String
                self.gender = fbResult["gender"] as? String
                if (self.gender == nil || self.gender == "male") {
                    self.genderSwitch!.on = false
                    self.femaleLabel!.alpha = 0.5
                } else {
                    self.genderSwitch!.on = true
                    self.maleLabel!.alpha = 0.5
                }
                // Set Profile Picture
                let imageUrlString:String = fbResult.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
                let imageUrl:NSURL = NSURL(string: imageUrlString)!
                let imageData:NSData = NSData(contentsOfURL: imageUrl)!
                let image = UIImage(data: imageData)
                self.profilePicIV.image = image
            }
            else {
                // Error Description
                println("Error: \(error.description)")
                let alertView = UIAlertView(title: "Oops somethings wrong", message: "Please try loging in again. Thank you", delegate: self, cancelButtonTitle: "Try Again")
                self.presentViewController(LoginVC(), animated: true, completion: nil)
            }
        })
    }
    
    // Helper Functions
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}