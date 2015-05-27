//
//  ViewController.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-25.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

/*
import UIKit
import Parse

class LoginViewC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, FBSDKLoginButtonDelegate {
    
    //Properties
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var bgImages = ["tutorial-image-1", "tutorial-image-2", "tutorial-image-3", "tutorial-image-4", "tutorial-image-5"]
    var pageSnapshots = ["Swipe for Tutorial", "Discover", "Chat", "Match", "Share"]
    var pageImages = ["Tinder-LogoFlame", "snapshot-1", "snapshot-2", "snapshot-3", "snapshot-4"]
    
    var instrucitonsPageVC : UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Getting the page View controller
        instrucitonsPageVC = self.storyboard?.instantiateViewControllerWithIdentifier("InstructionsPageVC") as! UIPageViewController
        self.instrucitonsPageVC.dataSource = self
        let pageContentVC = self.viewControllerAtIndex(0)
        self.instrucitonsPageVC.setViewControllers([pageContentVC!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.instrucitonsPageVC.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.addChildViewController(instrucitonsPageVC)
        self.view.addSubview(instrucitonsPageVC.view)
        self.instrucitonsPageVC.didMoveToParentViewController(self)
        // Setup Page Control
        pageControl.numberOfPages = pageSnapshots.count
        self.view.bringSubviewToFront(pageControl)
//        self.view.bringSubviewToFront(label)
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            self.view.bringSubviewToFront(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if (error != nil)
        {
            // Process error
            println("\(error.description)")
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            PFFacebookUtils.logInInBackgroundWithAccessToken(result.token, block: { (user: PFUser?, error:NSError?) -> Void in
                if let parseUser = user {
                    if parseUser.isNew {
                        println("User signed up and logged in through Facebook!")
                    } else {
                        println("User logged in through Facebook!")
                    }
                } else {
                    println("Uh oh. The user cancelled the Facebook login.")
                }
            })
            
//            // If you ask for multiple permissions at once, you
//            // should check if specific permissions missing
//            if result.grantedPermissions.contains("email")
//            {
//                // Do work
//            }
        }
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageContentVC).pageIndex!
        if ((index == 0) || (index == NSNotFound)) {
            return nil;
        }
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageContentVC).pageIndex!
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
        let pageContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentVC") as! PageContentVC
        pageContentVC.bgImage = self.bgImages[index]
        pageContentVC.snapshotImage = self.pageImages[index]
        pageContentVC.snapshotText = self.pageSnapshots[index]
        pageControl.currentPage = index
        pageContentVC.pageIndex = index
        
        return pageContentVC
    }
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return pageSnapshots.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }

}
*/
