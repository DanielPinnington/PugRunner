//
//  LoseScreen.swift
//  PugRunner
//
//  Created by Daniel Pinnington on 08/09/2019.
//  Copyright © 2019 DanielPinnington. All rights reserved.
//


import Foundation
import SpriteKit

class LoseScreen: SKScene, SKPhysicsContactDelegate{

    var myLabel : SKLabelNode!
    var myScore : SKLabelNode!
    var score : Int = 0
    
     override func didMove(to view: SKView) {
     //createLayer()
     createLabel()
    //buttonSegueMenu()
         //buttonLevelTwo()
        // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doaSegue"), object: nil)
     }
    func createLabel(){
     myScore = SKLabelNode(fontNamed: "Chalkduster")
     myScore?.text = "Score: \(score)"
     myScore.fontSize = 32
     myScore.position = CGPoint(x: 0, y: 400)
     self.addChild(myScore)
     }
}
