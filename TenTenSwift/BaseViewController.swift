//
//  BaseViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/4/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let gameManager: GameManager = GameManager.sharedManager()
    let positionArray: [CGPoint] = [CGPointMake(70, 300), CGPointMake(190, 300), CGPointMake(70, 420), CGPointMake(190, 420)];

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewGame(continueOrNot: Bool) {
        if !continueOrNot {
            gameManager.problemIndex = Int(arc4random_uniform(gameManager.problemsCount()))
        }
        
        refresh()
        display()
    }
    
    private func display() {
        for i in 0 ..< 4 {
            let imageView = CustomImageView(point: positionArray[i], number: Fraction(numerator: gameManager.getNumbers()[i]), imageNamePrefix: "operator")
            
            imageView.alpha = 0.4
            imageView.transform = CGAffineTransformMakeScale(0.6, 0.6)
            imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 180 * -20))
            self.view.addSubview(imageView)
            
            UIView.animateWithDuration(0.8, animations: {
                imageView.alpha = 1.0
                imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                imageView.transform = CGAffineTransformMakeRotation(0)
                }, completion: {
                    (value: Bool) in
                    
            })
        }
    }
    
    private func refresh() {
        for someView in self.view.subviews {
            if let customImageView = someView as? CustomImageView {
                customImageView.removeFromSuperview()
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
