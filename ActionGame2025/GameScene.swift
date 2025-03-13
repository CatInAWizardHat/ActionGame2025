//
//  GameScene.swift
//  ActionGame2025
//
//  Created by IMD 224 on 2025-03-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var sprite: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        sprite = SKSpriteNode(imageNamed: "PlayerSprite")
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sprite.size = CGSize(width: 75, height: 50)
        addChild(sprite)
        
        let opponentSprite = SKSpriteNode(imageNamed: "OpponentSprite")
        opponentSprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(opponentSprite)
        
        let downMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: 0), duration: 1)
        let upMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height), duration: 1)
        let movement = SKAction.sequence([downMovement, upMovement])
        opponentSprite.run(SKAction.repeatForever(movement))
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        sprite.run(SKAction.move(to: pos, duration: 1))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    }
}
