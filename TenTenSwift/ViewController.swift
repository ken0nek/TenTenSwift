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
    func add(point: CGPoint) -> CGPoint {
        return CGPointMake(self.x + point.x, self.y + point.y)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    let gameManager: GameManager = GameManager.sharedManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        display2()

        let customButton = CustomButton(point: CGPointMake(160, 80), imageNamePrefix: commandIconPrefixString)
        self.view.addSubview(customButton)
    }

//    func display1() {
//        
//        let customView1 = CustomView(point: CGPointMake(0, 220))
//        self.view.addSubview(customView1)
//
//        let customView2 = CustomView(point: CGPointMake(customView1.frame.origin.x + customView1.frame.size.width, customView1.frame.origin.y))
//        self.view.addSubview(customView2)
//        
//        let customView3 = CustomView(point: CGPointMake(customView1.frame.origin.x, customView1.frame.origin.y + customView1.frame.size.height))
//        self.view.addSubview(customView3)
//
//        let customView4 = CustomView(point: CGPointMake(customView1.frame.origin.x + customView1.frame.size.width, customView1.frame.origin.y + customView1.frame.size.height))
//        self.view.addSubview(customView4)
//    }

    func display2() {
        let positionArray: [CGPoint] = [CGPointMake(70, 300), CGPointMake(190, 300), CGPointMake(70, 420), CGPointMake(190, 420)];
        // let fractionArray: [Fraction] = [Fraction(numerator: 5), Fraction(numerator: 2), Fraction(numerator: 3), Fraction(numerator: 4)]
        gameManager.currentProblemIndex = Int(arc4random_uniform(340))
        for i in 0 ..< 4 {
            let imageView = CustomImageView(point: positionArray[i], number: Fraction(numerator: gameManager.getNumbers()[i]), imageNamePrefix: commandIconPrefixString)
            self.view.addSubview(imageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset() {
        for someView in self.view.subviews {
            if let customImageView = someView as? CustomImageView {
                customImageView.removeFromSuperview()
            }
        }

        display2()
    }
}

