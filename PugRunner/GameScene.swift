//
//  GameScene.swift
//  PugRunner
//
//  Created by Daniel Pinnington on 13/08/2019.
//  Copyright © 2019 DanielPinnington. All rights reserved.
//

import SpriteKit
import GameplayKit
import GameKit

class GameScene: SKScene, GKGameCenterControllerDelegate, SKPhysicsContactDelegate{
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        //
    }
    
    
    
    struct PhysicsCategory {
    static let none         : UInt32 = 0
    static let coin         : UInt32 = 1 << 0
    static let pugSpritecat : UInt32 = 1 << 2
    static let enemyCat     : UInt32 = 1 << 1  // 1
    }
    
    
    private var label      : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let pugSprite = SKSpriteNode(imageNamed: "pug0.png")
    let loopingBG:SKSpriteNode = SKSpriteNode(imageNamed: "Looping_BG")
    let loopingBG2:SKSpriteNode = SKSpriteNode(imageNamed: "Looping_BG")
    
    var pugFrames   = [SKTexture]()
    var myLabel     : SKLabelNode!
    var myScore     : SKLabelNode!
    var myHighScore : SKLabelNode!
    var time    = Timer()
    var finish  = Timer()
    var counter = 0 //Counter for score every frame (in update)
    
    var score = 0{
        didSet {
            myScore.text = "Score \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        createLabel()
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
            
            //pugSprite.zRotation = .pi / -5
            pugSprite.size = CGSize(width: 110, height: 85)
            pugSprite.anchorPoint = CGPoint(x: 7.5, y: 6.5)
            pugSprite.position = CGPoint (x: self.size.width/5, y: self.size.height/2)
            addChild(pugSprite)
            let textureAtlas = SKTextureAtlas(named: "PugSprites")
            for index in 0..<textureAtlas.textureNames.count{
               let textureNames = "pug" + String(index)
                pugFrames.append(textureAtlas.textureNamed(textureNames))
            }
            
            pugSprite.run(SKAction.repeatForever(SKAction.animate(with: pugFrames, timePerFrame: 0.05)))
            
             finish = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    
    
    func startLoopingBackground(){
        resetLoopingBackground()
        
        let move:SKAction = SKAction.moveBy(x: -loopingBG2.size.width, y: 0, duration: 20)
        let moveBack:SKAction = SKAction.moveBy(x: loopingBG2.size.width, y: 0, duration: 0)
        let seq:SKAction = SKAction.sequence([move, moveBack])
        let `repeat`:SKAction = SKAction.repeatForever(seq)
        
        loopingBG.run(`repeat`)
        loopingBG2.run(`repeat`)
    }
    
    
    @objc func timeToMoveOn() {
        endResult()
    }
    
    func endResult(){
                    let newScenee = LoseScreen(size: size)
                    newScenee.scaleMode = scaleMode
                    newScenee.score = score
                  let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                  view?.presentScene(newScenee, transition: reveal)
    }
    
    func createLabel(){
        myScore = SKLabelNode(fontNamed: "Chalkduster")
        myScore.text = "Score \(score)"
        myScore.fontSize = 32
        myScore.position = CGPoint(x: -500, y: 250)
    
        
        myHighScore = SKLabelNode(fontNamed: "Chalkduster")
        myHighScore.text = "Score \(score)"
        myHighScore.fontSize = 32
        myHighScore.position = CGPoint(x: -500, y: 350)
        self.addChild(myHighScore)
    }
    func spawnObstacle(){
        let coin = SKSpriteNode(imageNamed: "Fire") //This will eventually be changed to a different name
        
        coin.name = "enemy"
        coin.size = CGSize(width: 100, height: 78)
        coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.frame.size.width * 0.3) // 1
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.allowsRotation = false
        coin.physicsBody?.categoryBitMask = PhysicsCategory.coin
        coin.physicsBody?.collisionBitMask = PhysicsCategory.none
        }
    
    func spawnEnemy() {
        
        let enemy = SKSpriteNode(imageNamed: "coin1")
        
        let coin = SKTexture.init(imageNamed: "coin1")
        let coin2 = SKTexture.init(imageNamed: "coin2")
        let coin3 = SKTexture.init(imageNamed: "coin3")
        let coin4 = SKTexture.init(imageNamed: "coin4")
        let coin5 = SKTexture.init(imageNamed: "coin5")
        let coin6 = SKTexture.init(imageNamed: "coin6")
        
        let coinFrames: [SKTexture] = [coin, coin2, coin3, coin4, coin5, coin6]
        
        enemy.name = "enemy"
        enemy.size = CGSize(width: 35, height: 30)
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.frame.size.width * 0.3) // 1
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.allowsRotation = false
        enemy.physicsBody?.collisionBitMask = PhysicsCategory.none
        enemy.physicsBody?.usesPreciseCollisionDetection = true
        
        let animations = SKAction.animate(with: coinFrames, timePerFrame: 0.2)
        enemy.run(SKAction.repeatForever(animations))
        addChild(enemy)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if counter >= 60{
            score += 50
            counter = 0
        }else{
            counter += 1
        }
    }
    
    func resetLoopingBackground(){
        loopingBG.position = CGPoint(x: 0, y: 0)
        loopingBG2.position = CGPoint(x: loopingBG2.size.width - 3, y: 0)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
                
                 var firstBody: SKPhysicsBody
                       var secondbody: SKPhysicsBody
                       if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask){
                           firstBody = contact.bodyA
                           secondbody = contact.bodyB
                       }else{
                           firstBody = contact.bodyB
                           secondbody = contact.bodyA
                       }
                       if ((firstBody.categoryBitMask & PhysicsCategory.pugSpritecat != 0)
                           && secondbody.categoryBitMask & PhysicsCategory.enemyCat != 0){
                           secondbody.node?.removeFromParent()
                           score += 100
                       }
                       if((firstBody.categoryBitMask & PhysicsCategory.pugSpritecat != 0)
                           && secondbody.categoryBitMask & PhysicsCategory.coin != 0){
                           //Sound variable -- run()
                           secondbody.node?.removeFromParent()
                           if score > 0{
                               score -= 100
                           } else{
                           }
                       }
    }
}
