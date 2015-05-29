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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = PFUser.currentUser()
        
        emailTextField.text = currentUser?.email
        var string:String = currentUser["profilePicUrl"]
        var url = NSURL(string: string)
        var data = NSData(contentsOfURL: url)
        profilePicIV.image = UIImage(data: data)
        
        
    }
}
