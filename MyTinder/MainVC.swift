//
//  MainVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-27.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit
import Parse

class MainVC: UIViewController, FBSDKLoginButtonDelegate, CLLocationManagerDelegate {

    // Properties
    var currentUser = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request/Store User Location
        getUserPFGeoPoint()
        
        // Query Objects based on 5year Age Range, Location & Gender(Testing)
        
        
        // Testing Settings
        view.backgroundColor = UIColor.lightGrayColor()
        var test = UILabel(frame: CGRect(origin: view.center, size: CGSizeMake(200, 44)))
        test.text = "TEST"
        view.addSubview(test)
        // Facebook Log out Button
        let fbLoginButton : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(fbLoginButton)
        self.view.bringSubviewToFront(fbLoginButton)
        fbLoginButton.center = CGPoint(x: view.center.x, y: view.frame.size.height - view.frame.size.height / 8)
        fbLoginButton.readPermissions = ["public_profile", "email"]
        fbLoginButton.delegate = self
    }

    // Storing a user location in Parse
    func getUserPFGeoPoint() {
        // Get PFGeoPoint
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                // do something with the new geoPoint
                println("Successfully retrieved User Location: \(geoPoint)")
                self.currentUser?.setValue(geoPoint, forKey: "location")
                self.currentUser?.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError?) -> Void in
                    if (succeeded == true) {
                        // The object has been saved.
                        println("GeoPoint saved to Parse.")
                    } else {
                        // There was a problem, check error.
                        println(error?.description)
                    }
                })
            }
            println(error?.description)
        }
    }
    
    // Log Out Button
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {}

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        PFUser.logOut()
        println("Your logged Out")
        presentViewController(LoginVC(), animated: true, completion: nil)
    }
}
