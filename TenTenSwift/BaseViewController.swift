//
//  BaseViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/4/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

let Origin = CGPointMake(55, 280)
let Margin: CGFloat = 140
let xMargin = CGPointMake(Margin, 0)
let yMargin = CGPointMake(0, Margin)

let FirstPoint = Origin
let SecondPoint = CGPointMake(Origin.add(xMargin).x, Origin.y)
let ThirdPoint = CGPointMake(Origin.x, Origin.add(yMargin).y)
let FourthPoint = CGPointMake(Origin.add(xMargin).x, Origin.add(yMargin).y)

let positionArray: [CGPoint] = [FirstPoint, SecondPoint, ThirdPoint, FourthPoint];

class BaseViewController: UIViewController, GameDelegate {
    
    let gameManager: GameManager = GameManager.sharedManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProblemWithRepeat(repeat: Bool) {
        if !repeat {
            gameManager.problemIndex = Int(arc4random_uniform(gameManager.problemsCount()))
        }
        
        refresh()
        display()
    }
    
    private func display() {
        for i in 0 ..< 4 {
            let imageView = CustomImageView(frame: CGRectMake(positionArray[i].x, positionArray[i].y, 70, 70), number: Fraction(numerator: gameManager.getNumbers()[i]), imageNamePrefix: "operator", delegate: self)
            
            imageView.alpha = 0.4
            imageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
            imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI / 180 * -20))
            self.view.addSubview(imageView)
            
            UIView.animateWithDuration(0.3, animations: {
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
    
    func getViewController(identifier: String) -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier(identifier) as UIViewController
        return viewController
    }
    
    func gameWillClear(customImageView: CustomImageView) {
        let newImageView = CustomImageView(frame: CGRectMake(customImageView.frame.origin.x, customImageView.frame.origin.y, customImageView.frame.size.width, customImageView.frame.size.height), number: Fraction(numerator: 10), imageNamePrefix: customImageView.imageNamePrefix, delegate: self)
        
        newImageView.alpha = 0.0
        newImageView.transform = CGAffineTransformMakeScale(1.4, 1.4)
        
        UIView.animateWithDuration(0.4, animations: {
            customImageView.superview!.addSubview(newImageView)
            newImageView.alpha = 1.0
            newImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: {
                (value: Bool) in
                customImageView.alpha = 0.0
                customImageView.removeFromSuperview()
        })
        
        let rVC = ResultViewController.viewController(gameManager.getAnswerWithProblemID(0), time: 0, valuation: 0)
        self.navigationController.pushViewController(rVC, animated: true)
    }
    
    func gameDidClear(customImageView: CustomImageView) {
        
    }
    
    func gameWillStart(customImageView: CustomImageView) {
        
    }
    
    func gameDidStart(customImageView: CustomImageView) {
        
    }
    
    func gameWillNotClear(customImageView: CustomImageView, _ newFraction: Fraction) {
        let newImageView = CustomImageView(frame: CGRectMake(customImageView.frame.origin.x, customImageView.frame.origin.y, customImageView.frame.size.width, customImageView.frame.size.height), number: newFraction, imageNamePrefix: customImageView.imageNamePrefix, delegate: self)
        
        newImageView.alpha = 0.0
        newImageView.transform = CGAffineTransformMakeScale(1.4, 1.4)
        
        UIView.animateWithDuration(0.4, animations: {
            customImageView.superview!.addSubview(newImageView)
            newImageView.alpha = 1.0
            newImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: {
                (value: Bool) in
                customImageView.alpha = 0.0
                customImageView.removeFromSuperview()
        })
    }
    
    func gameDidNotClear(customImageView: CustomImageView) {
        
    }
    
    func gameWillContinue(customImageView: CustomImageView, _ newFraction: Fraction) {
        
        let newImageView = CustomImageView(frame: CGRectMake(customImageView.frame.origin.x, customImageView.frame.origin.y, customImageView.frame.size.width, customImageView.frame.size.height), number: newFraction, imageNamePrefix: customImageView.imageNamePrefix, delegate: self)
        
        newImageView.alpha = 0.0
        newImageView.transform = CGAffineTransformMakeScale(1.4, 1.4)
        
        UIView.animateWithDuration(0.4, animations: {
            customImageView.superview!.addSubview(newImageView)
            newImageView.alpha = 1.0
            newImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: {
                (value: Bool) in
                customImageView.alpha = 0.0
                customImageView.removeFromSuperview()
        })
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
