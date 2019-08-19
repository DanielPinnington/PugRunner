//
//  GameViewController.swift
//  PugRunner
//
//  Created by Daniel Pinnington on 13/08/2019.
//  Copyright © 2019 DanielPinnington. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate{
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
       //
    }
    

    
    var score = GameScene().myScore
    var Highscore = GameScene().myHighScore
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
            
            
            let button = UIButton(frame: CGRect(x: 100, y:100, width: 100, height: 50))
            button.backgroundColor = .green
            button.setTitle("leaderboards", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            self.view.addSubview(button)
        }
    }
    @objc func buttonAction(sender: UIButton!){
        showLeaderboard()
    }
    
    func authPlayer(){
        let localPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = {
            (view, Error) in
            if view != nil{
                self.present(view!, animated: true, completion: nil)
            }else{
                print(GKLocalPlayer.local.isAuthenticated)
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func saveHighScore(number : Int){
        if(GKLocalPlayer.local.isAuthenticated){
            //tHIS NEEDS FIXING]
            if GKLocalPlayer.local.isAuthenticated{
                let scoreReported = GKScore(leaderboardIdentifier: "This")
                scoreReported.value = Int64(number)
                let scoreArray : [GKScore] = [scoreReported]
                
                GKScore.report(scoreArray, withCompletionHandler: nil)
            }
        }
    }
    
    func showLeaderboard(){
        let viewController = self.view.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        
        gcvc.gameCenterDelegate = self
        
        viewController?.present(gcvc, animated: true, completion: nil)
    }
}

func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController){
    gameCenterViewController.dismiss(animated: true, completion:nil)
}
