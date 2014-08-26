//
//  GameManager.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/26/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

enum GameLevel: Int {
    case Easy, Normal, Hard
}

extension Int {
    func convertIntoArray() -> [Int] {
        var figures: [Int] = [Int]()
        var combinationInt = self
        for i in 0 ..< 4 {
            figures.append(combinationInt % 10)
            combinationInt /= 10
        }

        return figures
    }
}

class GameManager: NSObject {
    var gameLevel: Int = 0
    var currentProblemIndex: Int = 0
    let problems: [[AnyObject]] = GameManager.loadProblems()

    class func sharedManager() -> GameManager {
        struct Singleton {
            static let instance = GameManager()
        }
        return Singleton.instance
    }
    
    override init() {
        
    }

    private class func loadProblems() -> [[AnyObject]] {
        let filePath = NSBundle.mainBundle().pathForResource("combination", ofType: "csv")
        if filePath != nil {
            let contentOfFile = NSString.stringWithContentsOfFile(filePath!, encoding: NSUTF8StringEncoding, error: nil)
            let lines = contentOfFile.componentsSeparatedByString("\n")
            var aLineArray: [[AnyObject]] = []
            for aLine in lines {
                aLineArray.append(aLine.componentsSeparatedByString(","))
            }
            return aLineArray
        } else {
            fatalError("CSV file has not been loaded")
            return []
        }
    }

    func getNumbers() -> [Int] {
        return makeProblemSet(problems[currentProblemIndex]).numbers
    }
    
    func getAnswer() -> String {
        return makeProblemSet(problems[currentProblemIndex]).answer
    }
    
    private func makeProblemSet(aLineArray: [AnyObject]) -> (problemID: Int, problemLevel: Int, numbers: [Int], answer: String) {
        
        return ((aLineArray[0] as String).toInt()!, (aLineArray[1] as String).toInt()! , (aLineArray[2] as String).toInt()!.convertIntoArray(), aLineArray[3] as String)
    }
}