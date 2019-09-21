//
//  ViewController.swift
//  MobileComputing 15060289
//
//  Created by Daniel Pinnington on 09/11/2018.
//  Copyright © 2018 Daniel Pinnington. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController{//}, GameSceneDelegate {

    
    var time = Timer()
    var finish = Timer()
    var seconds = 0
    var score = Int()
    var scoreCoin = Int(50)
    var timerIsOn = false
    var startLocation: CGPoint?
    var background = [UIImageView]()
    var spaceshipIndex = 1
    var gameTime = Timer()
    var spawnTime = Timer()
    var resetBackground = 0
    var minuteCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skview = view as! SKView
        let spaceGame = (MenuScene(size: skview.bounds.size))
        //skview.showsPhysics = true
        skview.showsFPS = true
        skview.showsNodeCount = true
        spaceGame.viewController = self
        skview.presentScene(spaceGame)
        
//        NotificationCenter.default.addObserver(self, selector: #selector (LoseScreen.doaSegue), name:  NSNotification.Name(rawValue: "doaSegue"), object: nil)
    }
    
    func doaSegue(){
        performSegue(withIdentifier: "toNext", sender: self)
        self.view.removeFromSuperview()
        self.view = nil
    }
    override var shouldAutorotate: Bool {
        return true
    }
}

