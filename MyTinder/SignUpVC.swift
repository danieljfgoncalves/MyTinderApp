//
//  SignUpVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-28.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    // Properties
    var fbID:String!
    var gender:String!
    
    @IBOutlet weak var profilePicIV: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBAction func switchedGender(sender: AnyObject) {
        if genderSwitch.on {
            println("female")
            self.gender = "female"
            self.maleLabel.alpha = 0.3
            self.femaleLabel.alpha = 1
        } else {
            println("male")
            self.gender = "male"
            self.femaleLabel.alpha = 0.3
            self.maleLabel.alpha = 1
        }
    }
    @IBAction func signUpButton(sender: AnyObject) {
    
        // Send to Parse
        if let user = PFUser.currentUser() {
            var imageData:NSData = UIImagePNGRepresentation(profilePicIV.image)
//            var imagePFFile:PFFile = PFFile.file
        }
        
        
//        user["profilePicUrl"]   = result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
//        user.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError?) -> Void in
//            if (succeeded == true) {
//                // The object has been saved.
//                println("Info saved to Parse.")
//                
//                // Present next View Controller
//                self.presentViewController(MainVC(), animated: true, completion: nil)
//                
//            } else {
//                // There was a problem, check error.
//                println("\(error?.description)")
//            }
//        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fill Fields with Facebook Info
        fbGraphRequest()
        
        
////        var currentUser = PFUser.currentUser()
////
//        if let currentUser = PFUser.currentUser(),
//            let url = currentUser["profilePicUrl"] as? String{
//            profilePicIV.image = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
//        }
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)

    }
    
    // Facebook Graph Request
    func fbGraphRequest() {
        
        let graphUrl = "me?fields=id,name,gender,email,picture.type(square).width(300).height(300)"
        
        let fbGraphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: graphUrl, parameters: nil)
        fbGraphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if (error != nil) {
                // Error Description
                println("Error: \(error.description)")
                self.presentViewController(LoginVC(), animated: true, completion: nil)
            }
            else {
//                println("\(result)")
                // Set textfields
                self.emailTextField.text    = result["email"] as? String
                self.fbID                   = result["id"] as? String
                self.nameTextField.text     = result["name"] as? String
                self.gender                 = result["gender"] as? String
                if (self.gender == nil || self.gender == "male") {
                    self.genderSwitch.on = false
                    self.femaleLabel.alpha = 0.5
                } else {
                    self.genderSwitch.on = true
                    self.maleLabel.alpha = 0.5
                }
                // Set Profile Picture
                var imageUrl:String = result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
                self.profilePicIV.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imageUrl)!)!)
            }
        })
    }
    
    // Helper Functions
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
}
