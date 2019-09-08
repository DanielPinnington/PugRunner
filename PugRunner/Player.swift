//
//  Player.swift
//  PugRunner
//
//  Created by Daniel Pinnington on 13/08/2019.
//  Copyright © 2019 DanielPinnington. All rights reserved.
//

import Foundation
import SpriteKit


class Player : SKSpriteNode{
    
    var jumpAction : SKAction?
    var runAction:SKAction?
    var glideAction:SKAction?
    var fireAction:SKAction?
    
    var isJumping  : Bool    = false
    var isRunning  : Bool    = true
    var isGliding  : Bool    = false
    var jumpAmount : CGFloat = 0
    var minSpeed   : CGFloat = 15
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    
        func update() {
            /*if (isGliding == true) {
             self.position = CGPointMake(self.position.x + minSpeed, self.position.y - 0.4)
             } else {
             self.position = CGPointMake(self.position.x + minSpeed, self.position.y + jumpAmount)
             }*/
            self.position.x += minSpeed;
        }
        
        func setUpRun() {
            let atlas = SKTextureAtlas (named: "Pug")
            var atlasTextures:[SKTexture] = []
            
            //for i in 0 ..< 9{
              //  let texture:SKTexture = atlas.textureNamed( String(format: "bro3_walk000%i", i+1))
               // atlasTextures.insert(texture, at:i)
            }
        
    }
}
