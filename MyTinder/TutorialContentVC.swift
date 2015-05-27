//
//  TutorialVC.swift
//  MyTinder
//
//  Created by Daniel Goncalves on 2015-05-27.
//  Copyright (c) 2015 Daniel Goncalves. All rights reserved.
//

import UIKit

class TutorialContentVC: UIViewController {
    
    
    // Properties
    var bgIV:UIImageView!
    var snapshotIV:UIImageView!
    var snapshotTitle:UILabel!
    
    var pageIndex:Int?
    var bgImage:String!
    var snapshotImage:String!
    var snapshotText:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Background Image
        bgIV = UIImageView(image: UIImage(named: self.bgImage))
//        bgIV.backgroundColor = UIColor.redColor()
        bgIV.frame = self.view.frame
        view.addSubview(bgIV)
        
        // Set Snapshot Image
        snapshotIV = UIImageView(image: UIImage(named: snapshotImage))
//        snapshotIV.backgroundColor = UIColor.blueColor()
        snapshotIV.frame = CGRect(x: 0, y: self.view.frame.height / 4, width: self.view.frame.width, height: self.view.frame.height / 2.5)
        snapshotIV.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(snapshotIV)
        
        // Set Title Label
        snapshotTitle = UILabel(frame: CGRect(x: 0, y: self.snapshotIV.frame.origin.y - 44, width: self.view.frame.width, height: 44))
        snapshotTitle.text = snapshotText
        snapshotTitle.textColor = UIColor.whiteColor()
//        snapshotTitle.backgroundColor = UIColor.orangeColor()
        snapshotTitle.textAlignment = NSTextAlignment.Center
        view.addSubview(snapshotTitle)
    }
    
    // Deal with warnings
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
