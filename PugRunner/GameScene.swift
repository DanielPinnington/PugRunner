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

class GameScene: SKScene {
    
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let pugSprite = SKSpriteNode(imageNamed: "pug0.png")
    var pugFrames = [SKTexture]()
    var myLabel : SKLabelNode!
    var myScore : SKLabelNode!
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
            
            
            
            //    @objc func timeToMoveOn() {
            //       endResult()
            
            //     }
        //}
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func createLabel(){
        myScore = SKLabelNode(fontNamed: "Chalkduster")
        myScore.text = "Score \(score)"
        myScore.fontSize = 32
        myScore.position = CGPoint(x: -500, y: 250)
    
        self.addChild(myScore)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        if counter >= 60{
            score += 50
            counter = 0
        }else{
            counter += 1
        }
    }
}
