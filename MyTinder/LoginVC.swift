//
//  LoginVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-27.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    
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
//        pageControl.backgroundColor = UIColor.blackColor()
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        
        // Set Logo
        var logo = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 40), size: CGSizeMake(view.frame.width, 50)))
//        logo.backgroundColor = UIColor.blackColor()
        logo.image = UIImage(named: "myTinder-Logo")
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(logo)
        view.bringSubviewToFront(logo)
        
        // Facebook Login
        
    }
    
    // Tutorial PageViewController functions
            // UIPageViewControllerDataSource required functions
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
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool)
    {
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
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return pageSnapshots.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
}
