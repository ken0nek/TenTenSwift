//
//  ViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 6/18/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit
import QuartzCore

extension CGPoint {
    func addPoint(point: CGPoint) -> CGPoint {
        return CGPointMake(self.x + point.x, self.y + point.y)
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let customView1 = CustomView(frame: CGRectMake(0, 248, 160, 160))
        self.view.addSubview(customView1)

        let customView2 = CustomView(frame: CGRectMake(160, 248, 160, 160))
        self.view.addSubview(customView2)
        
        let customView3 = CustomView(frame: CGRectMake(0, 408, 160, 160))
        self.view.addSubview(customView3)

        let customView4 = CustomView(frame: CGRectMake(160, 408, 160, 160))
        self.view.addSubview(customView4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

