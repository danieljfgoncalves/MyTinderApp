//
//  LoginVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-27.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate, FBSDKLoginButtonDelegate {
    
    // Properties
    var tutorialVC:UIPageViewController!
    var bgImages = ["tutorial-image-5", "tutorial-image-2", "tutorial-image-3", "tutorial-image-4", "tutorial-image-1"]
    var pageSnapshots = ["Swipe for Tutorial ->", "Discover", "Chat", "Match <3", "Share"]
    var pageImages = ["snapshot-5", "snapshot-1", "snapshot-2", "snapshot-3", "snapshot-4"]
    
    var pageControl:UIPageControl!
    var currentPageVC: TutorialContentVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the tutorial PageVC
        tutorialVC = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        tutorialVC.dataSource = self
        tutorialVC.delegate = self
        // Setting the tutorial content VC
        let tutorialContentVC = viewControllerAtIndex(0)
        tutorialVC.setViewControllers([tutorialContentVC!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        tutorialVC.view.frame = self.view.frame
        addChildViewController(tutorialVC)
        view.addSubview(tutorialVC.view)
        tutorialVC.didMoveToParentViewController(self)
        // Setting the Page control
        pageControl = UIPageControl(frame: CGRect(origin: CGPoint(x: 0, y: (view.frame.height / 3) * 2), size: CGSizeMake(CGRectGetWidth(view.bounds), 20)))
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageImages.count
        pageControl.userInteractionEnabled = false
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        // Set Logo
        var logo = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 40), size: CGSizeMake(view.frame.width, 50)))
        logo.image = UIImage(named: "myTinder-Logo")
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(logo)
        view.bringSubviewToFront(logo)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if FBSDKAccessToken.currentAccessToken() != nil
        {
            // User is already logged in, do work such as go to next view controller.
            presentViewController(MainVC(), animated: true, completion: nil)
        }
        else
        {
            let fbLoginButton : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(fbLoginButton)
            self.view.bringSubviewToFront(fbLoginButton)
            fbLoginButton.center = CGPoint(x: view.center.x, y: view.frame.size.height - view.frame.size.height / 8)
            fbLoginButton.readPermissions = ["public_profile", "email", "user_likes"]
            fbLoginButton.delegate = self
        }
    }
    
    // Facebook Login Delegate functions
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

        PFFacebookUtils.logInInBackgroundWithAccessToken(result.token, block: { (user: PFUser?, error: NSError?) -> Void in
            
            let parseUser = user
            
            if parseUser == nil {
                println("Uh oh. The user cancelled the Facebook login.")
                println("\(error?.description)")
                
                let alertView = UIAlertView(title: "Oops somethings wrong", message: "Please try loging in again. Thank you", delegate: self, cancelButtonTitle: "Try Again")
                
            } else if parseUser!.isNew {
                println("User signed up and logged in through Facebook!")
            } else {
                println("User logged in through Facebook!")
                self.fbGraphRequestAndParse(parseUser!)
            }
        })
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        PFUser.logOut()
    }
    
    // Facebook Graph Request
    func fbGraphRequestAndParse(user: PFUser) {
        
        let graphUrl = "me?fields=id,name,picture.type(square).width(300).height(300),age_range,gender,email,sports,favorite_teams"
        
        let fbGraphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: graphUrl, parameters: nil)
        fbGraphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if (error != nil) {
                // Error Description
                println("Error: \(error.description)")
            }
            else {
                println("\(result)")
                
                // Sent to Parse
                user.email              = result["email"] as? String
                user["fbID"]            = result["id"]
                user["fullName"]        = result["name"]
                user["gender"]          = result["gender"]
                user["profilePicUrl"]   = result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
                user.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError?) -> Void in
                    if (succeeded == true) {
                        // The object has been saved.
                        println("Info saved to Parse.")
                        
                        // Present next View Controller
                        self.presentViewController(MainVC(), animated: true, completion: nil)
                        
                    } else {
                        // There was a problem, check error.
                        println("\(error?.description)")
                    }
                })
            }
        })
    }
    
    // Tutorial PageViewController functions
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialContentVC).pageIndex!
        if ((index == 0) || (index == NSNotFound)) {
            return nil;
        }
        index--

        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialContentVC).pageIndex!
        if (index == NSNotFound) {
            return nil
        }
        index++

        if(index == self.pageImages.count){
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        
        if ((self.pageSnapshots.count == 0) || (index >= self.pageSnapshots.count)) {
            return nil
        }
        let tutorialContentVC = TutorialContentVC()
        tutorialContentVC.bgImage       = self.bgImages[index]
        tutorialContentVC.snapshotText  = self.pageSnapshots[index]
        tutorialContentVC.snapshotImage = self.pageImages[index]
        tutorialContentVC.pageIndex     = index
        
        return tutorialContentVC
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if finished && completed {
            let vc = previousViewControllers[0] as! TutorialContentVC
            if let currentVC = self.currentPageVC {
                self.pageControl.currentPage = currentVC.pageIndex!
            }

        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        if pendingViewControllers.count > 0{
            let vc = pendingViewControllers[0] as! TutorialContentVC

            self.currentPageVC = vc

        }
    }
}
