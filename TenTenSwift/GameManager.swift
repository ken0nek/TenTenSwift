//
//  GameManager.swift
//  TenTenSwift
//
//  Created by Ken Tominaga on 8/26/14.
//  Copyright (c) 2014 Tommy. All rights reserved.
//

import UIKit

let ProblemsCount: UInt32 = 340
let EasyProblemsCount: UInt32 = 78
let NormalProblemsCount: UInt32 = 84
let HardProblemsCount: UInt32 = 178

enum GameLevel: Int {
    case Easy, Normal, Hard

    func count() -> UInt32 {
        switch self {
            case .Easy: return EasyProblemsCount
case .Normal: return NormalProblemsCount
case .Hard: return HardProblemsCount
}
}
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
    var gameLevel: GameLevel = .Easy
    var problemIndex: Int = 0
    let problems: [[AnyObject]] = GameManager.loadProblems()
    var problemsByLevel: [[AnyObject]] {
        get{
            return loadProblemsByLevel()
        }
    }

    class func sharedManager() -> GameManager {
        struct Singleton {
            static let instance = GameManager()
        }
        return Singleton.instance
    }
    
    override init() {
        
    }

    private func loadProblemsByLevel() -> [[AnyObject]] {
        
        var problemsByLevelArray: [[AnyObject]] = []
        for aProblem in problems {
            if makeProblemSet(aProblem).problemLevel == gameLevel.toRaw() {
                problemsByLevelArray.append(aProblem)
            }
        }
        
        return problemsByLevelArray
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
        return makeProblemSet(problemsByLevel[problemIndex]).numbers
    }
    
    func getAnswer() -> String {
        return makeProblemSet(problemsByLevel[problemIndex]).answer
    }

    func problemsCount() -> UInt32 {
        return gameLevel.count()
    }
    
    private func makeProblemSet(aLineArray: [AnyObject]) -> (problemID: Int, problemLevel: Int, numbers: [Int], answer: String) {
        
        return ((aLineArray[0] as String).toInt()!, (aLineArray[1] as String).toInt()! , (aLineArray[2] as String).toInt()!.convertIntoArray(), aLineArray[3] as String)
    }
}