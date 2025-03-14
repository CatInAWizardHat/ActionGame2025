//
//  GameScene.swift
//  ActionGame2025
//
//  Created by IMD 224 on 2025-03-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var sprite: SKSpriteNode!
    var opponentSprite: SKSpriteNode!
    var scoreDisplay: SKLabelNode!
    
    let spriteCategory1: UInt32 = 0b1
    let spriteCategory2: UInt32 = 0b10
    
    let spriteOffset: CGFloat = 40.0
    let offScreenOffset: Int = 100
    var playerScore: Int = 0
    
    override func didMove(to view: SKView) {
        sprite = SKSpriteNode(imageNamed: "PlayerSprite")
        sprite.position = CGPoint(x: size.width / 2, y: spriteOffset)
        sprite.size = CGSize(width: 150, height: 100)
        addChild(sprite)
        
        opponentSprite = SKSpriteNode(imageNamed: "OpponentSprite")
        opponentSprite.position = CGPoint(x: size.width / 2, y: size.height)
        addChild(opponentSprite)
        
        scoreDisplay = SKLabelNode(text: playerScore.description)
        scoreDisplay.fontSize = 75
        scoreDisplay.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(scoreDisplay)
        //        let downMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: 0), duration: 1)
        //        let upMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height), duration: 1)
        //        let movement = SKAction.sequence([downMovement, upMovement])
        moveOpponent(randomX: Int(size.width / 2))
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 75)
        opponentSprite.physicsBody = SKPhysicsBody(circleOfRadius: 75)
        sprite.physicsBody?.categoryBitMask = spriteCategory1
        sprite.physicsBody?.contactTestBitMask = spriteCategory1
        sprite.physicsBody?.collisionBitMask = spriteCategory1
        opponentSprite.physicsBody?.categoryBitMask = spriteCategory1
        opponentSprite.physicsBody?.contactTestBitMask = spriteCategory1
        opponentSprite.physicsBody?.collisionBitMask = spriteCategory1
        self.physicsWorld.contactDelegate = self
    }
    
    func moveOpponent(randomX: Int) {
        //        let randomX = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.width))
        //        let randomY = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.height))
        //        let movement = SKAction.move(to: CGPoint(x: randomX, y: randomY), duration: 1)
        let duration = GKRandomSource.sharedRandom().nextInt(upperBound: 4)
        let movement = SKAction.move(to: CGPoint(x: randomX, y: 0), duration: Double(duration))
        opponentSprite.run(movement, completion: { [unowned self] in
            opponentSprite.removeAllActions()
            resetOpponent()
        })
    }
    
    
    func resetOpponent() {
        let randomX = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.width) - offScreenOffset) + offScreenOffset
        opponentSprite.run(SKAction.move(to: CGPoint(x: randomX, y: Int(size.height)), duration: 0), completion: { [unowned self] in
            opponentSprite.removeAllActions()
            moveOpponent(randomX: randomX)
        })
    }
    
    func updateScore(position: CGPoint) {
        playerScore = position.y < 1 ? playerScore - 1 : playerScore + 1
        scoreDisplay.text = playerScore.description
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        sprite.run(SKAction.move(to: CGPoint(x: pos.x, y: spriteOffset), duration: 1))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        opponentSprite.removeAllActions()
        updateScore(position: opponentSprite.position)
        resetOpponent()
    }
    
    func gameOver() {
        opponentSprite.removeAllActions()
        opponentSprite.isHidden = true
        sprite.isHidden = true
        scoreDisplay.text = "Game Over"
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
        if playerScore == -1 {
            gameOver()
        }
        if opponentSprite.position.y < 10 {
            updateScore(position: opponentSprite.position)
        }
    }
}
