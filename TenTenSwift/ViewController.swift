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

    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        display()

        let fraction1 = Fraction()
        fraction1.description()

        let fraction2 = Fraction(numerator: 5)
        fraction2.description()

        let fraction3 = Fraction(numerator: 4, denominator: 3)
        fraction3.description()

        let fraction4 = Fraction(numerator: 8, denominator: 4)
        fraction4.description()

        let fraction5 = Fraction(numerator: -4, denominator: 3)
        fraction5.description()

        let fraction6 = Fraction(numerator: -4, denominator: -2)
        fraction6.description()

        let fraction7 = Fraction(numerator: 4, denominator: -3)
        fraction7.description()
    }

    func display() {
        
        let customView1 = CustomView(point: CGPointMake(0, 220))
        self.view.addSubview(customView1)

        let customView2 = CustomView(point: CGPointMake(customView1.frame.origin.x + customView1.frame.size.width, customView1.frame.origin.y))
        self.view.addSubview(customView2)
        
        let customView3 = CustomView(point: CGPointMake(customView1.frame.origin.x, customView1.frame.origin.y + customView1.frame.size.height))
        self.view.addSubview(customView3)

        let customView4 = CustomView(point: CGPointMake(customView1.frame.origin.x + customView1.frame.size.width, customView1.frame.origin.y + customView1.frame.size.height))
        self.view.addSubview(customView4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset() {
        for someView in self.view.subviews {
            if let customView = someView as? CustomView {
                customView.removeFromSuperview()
            }
        }

        display()
    }
}

