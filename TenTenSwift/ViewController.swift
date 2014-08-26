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

class ViewController: BaseViewController {

@IBOutlet weak var answerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        startNewGame(true)

        let gameLevelSelectButton = GameLevelSelectButton(frame: CGRectMake(120, 120, 80, 80), imageNamePrefix: GameLevelSelectPrefixString)
        self.view.addSubview(gameLevelSelectButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func replay2() {
        answerLabel.text = "Do not Google !"
        startNewGame(true)
    }

    @IBAction func reset2() {
        answerLabel.text = "Do it yourself !"
        startNewGame(false)
    }
    
    @IBAction func showAnswer() {
        answerLabel.text = gameManager.getAnswer()
    }
}

