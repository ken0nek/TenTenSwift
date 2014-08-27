//
//  TopViewController.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/27/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

class TopViewController: BaseViewController, GameLevelSelectButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        let gameLevelSelectButton = GameLevelSelectButton(frame: CGRectMake(120, 120, 80, 80), imageNamePrefix: GameLevelSelectPrefixString, delegate: self)
        self.view.addSubview(gameLevelSelectButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameLevelSelectButtonDidSwipe(direction: Direction) {
        if direction != .Down {
            gameManager.gameLevel = direction.toGameLevel()
            let smVC = getViewController("Simple") as SimpleModeViewController
            self.navigationController.pushViewController(smVC, animated: true)
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
