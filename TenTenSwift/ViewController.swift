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
        
        let button = CustomButton(frame: CGRectMake(320/2, 568/2, 60, 60))
        self.view.addSubview(button)

        let anotherButton = CustomButton(frame: CGRectMake(0, 568/2, 60, 60))
        self.view.addSubview(anotherButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

