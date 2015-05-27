//
//  LoginVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-27.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UIPageViewControllerDataSource {
    
    // Properties
    var tutorialVC:UIPageViewController!
    var bgImages = ["tutorial-image-5", "tutorial-image-2", "tutorial-image-3", "tutorial-image-4", "tutorial-image-1"]
    var pageSnapshots = ["Swipe for Tutorial ->", "Discover", "Chat", "Match <3", "Share"]
    var pageImages = ["snapshot-5", "snapshot-1", "snapshot-2", "snapshot-3", "snapshot-4"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Setting the tutorial PageVC
        tutorialVC = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        tutorialVC.dataSource = self
        // Setting the tutorial content VC
        let tutorialContentVC = viewControllerAtIndex(1)
        tutorialVC.setViewControllers([tutorialContentVC!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        tutorialVC.view.frame = self.view.frame
        addChildViewController(tutorialVC)
        view.addSubview(tutorialVC.view)
        tutorialVC.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
}
