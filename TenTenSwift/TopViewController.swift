//
//  TopViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/27/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

let isIPhone: Bool = UIDevice.currentDevice().userInterfaceIdiom == .Phone ? true : false

class TopViewController: BaseViewController, GameLevelSelectButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Top"
        
        let simpleModeButton = GameLevelSelectButton(frame: CGRectMake(120, 120, 80, 80), imageNamePrefix: SimpleModePrefixString, delegate: self)
        simpleModeButton.tag = 100
        self.view.addSubview(simpleModeButton)
        
        let timeAttackButton = GameLevelSelectButton(frame: CGRectMake(120, 280, 80, 80), imageNamePrefix: TimeAttackPrefixString, delegate: self)
        timeAttackButton.tag  = 101
        self.view.addSubview(timeAttackButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameLevelSelectButtonDidSwipe(button: GameLevelSelectButton, direction: Direction) {
        if direction != .Down {
            gameManager.gameLevel = direction.toGameLevel()
            switch button.tag - 100 {
            case 0: // Simple
                gameManager.gameType = .Simple
                let smVC = getViewController("Simple") as SimpleModeViewController
                self.navigationController.pushViewController(smVC, animated: false)
            case 1: // Time Attack
                gameManager.gameType = .TimeAttack
                let tamVC = getViewController("TimeAttack") as TimeAttackModeViewController
                self.navigationController.pushViewController(tamVC, animated: false)
            default: println("hoge")
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
