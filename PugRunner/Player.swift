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
    
    
    var isJumping  : Bool    = false
    var isRunning  : Bool    = true
    var isGliding  : Bool    = false
    var jumpAmount : CGFloat = 0
    var minSpeed   : CGFloat = 15
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
