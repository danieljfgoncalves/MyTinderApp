//
//  MainVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-27.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class MainVC: UIViewController, FBSDKLoginButtonDelegate, CLLocationManagerDelegate {

    var locationManager:CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.greenColor()
        var test = UILabel(frame: CGRect(origin: view.center, size: CGSizeMake(200, 44)))
        test.text = "TEST"
        view.addSubview(test)
        // Facebook Log out Button
        let fbLoginButton : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(fbLoginButton)
        self.view.bringSubviewToFront(fbLoginButton)
        fbLoginButton.center = CGPoint(x: view.center.x, y: view.frame.size.height - view.frame.size.height / 8)
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginButton.delegate = self
        
//        // Location Manager
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
//        var userLocation = locationManage
        
    }

    // Storing a user location in Parse
    
    // Log Out Button
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {}

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        PFUser.logOut()
        println("Your logged Out")
        presentViewController(LoginVC(), animated: true, completion: nil)
    }
}
