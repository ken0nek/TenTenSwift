//
//  BaseViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/4/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

typealias BasicCompletion = (success:Bool?,obj:AnyObject?) -> Void

let DisplaySize = CGSizeMake(320, 568)

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
    private var time: Int = 0
    private var gameTimer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        gameTimer.fire()
    }
    
    override func viewWillDisappear(animated: Bool) {
        time = 0
        gameTimer.invalidate()
    }
    
    func update() {
        time++
    }
    
    func showProblemWithRepeat(repeat: Bool) {
        if !repeat {
            gameManager.problemIndex = gameManager.gameLevel.random()
        }
        
        refresh { (success, obj) -> Void in
            self.display()
        }
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
    
    private func refresh(completion: BasicCompletion) {
        for someView in self.view.subviews {
            if let customImageView = someView as? CustomImageView {
                customImageView.removeFromSuperview()
            }
        }
        
        completion(success: true, obj: nil)
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
        
        let rVC = ResultViewController.viewController(gameManager.getAnswer(), time: time)
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
        
        let rVC = ResultViewController.viewController(gameManager.getAnswer(), time: -1)
        self.navigationController.pushViewController(rVC, animated: true)
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
    
    func setHomeButton() {
        let homeButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        homeButton.setBackgroundImage(UIImage(named: "numberBackground0"), forState: UIControlState.Normal)
        homeButton.frame = CGRectMake(0, 0, 44, 44)
        homeButton.addTarget(self, action: Selector("backToTop"), forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: homeButton)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func backToTop() {
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func setNextButton() {
        let nextButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        nextButton.frame = CGRectMake(0, DisplaySize.height - 44, DisplaySize.width, 44)
        nextButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        nextButton.setTitle("NEXT PROBLEM", forState: UIControlState.Normal)
        nextButton.addTarget(self, action: Selector("didPressNextButton"), forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.setBackgroundImage(UIImage(named: ""), forState: UIControlState.Normal)
        self.view.addSubview(nextButton)
    }
    
    func didPressNextButton() {
        self.navigationController.popViewControllerAnimated(true)
    }
    
    func setReplayButton() {
        
    }
    
    func setGiveupButton() {
        
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
