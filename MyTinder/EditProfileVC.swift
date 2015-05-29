//
//  EditProfileVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-28.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit
import Parse

class EditProfileVC: UIViewController {

    // Properties
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
            self.maleLabel.alpha = 0.5
        } else {
            println("male")
            self.gender = "female"
            self.femaleLabel.alpha = 0.5
        }
    }
    
    var fbID:String!
    var gender:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
////        var currentUser = PFUser.currentUser()
////
//        if let currentUser = PFUser.currentUser(),
//            let url = currentUser["profilePicUrl"] as? String{
//            profilePicIV.image = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
//        }
       
        
        fbGraphRequest()
        
        
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
                
                // Send to Parse
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
                
                var imageUrl:String = result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
                
                self.profilePicIV.image = UIImage(data: NSData(contentsOfURL: NSURL(string: imageUrl)!)!)
                
            }
        })
    }
}
