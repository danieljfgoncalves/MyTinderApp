//
//  MainVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-27.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit
import Parse

class MainVC: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.greenColor()
        
        var test = UILabel(frame: CGRect(origin: view.center, size: CGSizeMake(200, 44)))
        test.text = "TEST"
        view.addSubview(test)
        
        let fbLoginButton : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(fbLoginButton)
        self.view.bringSubviewToFront(fbLoginButton)
        fbLoginButton.center = CGPoint(x: view.center.x, y: view.frame.size.height - view.frame.size.height / 8)
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginButton.delegate = self
        
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {}

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        PFUser.logOut()
        presentViewController(LoginVC(), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
