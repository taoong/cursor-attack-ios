//
//  GameScene.swift
//  CursorAttack
//
//  Created by Tao Ong on 3/11/18.
//  Copyright © 2018 Tao Ong. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode()
    var enemy = SKSpriteNode()
    var restartBtn = SKSpriteNode()
    
    var gameOver = false
    var gameStopped = false
    
    override func sceneDidLoad() {
        self.createRestartBtn()
        physicsWorld.contactDelegate = self
        player = self.childNode(withName: "player") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    
    func createScene() {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if gameOver == false {
            if contact.bodyA.node == player && contact.bodyB.node == enemy ||
                contact.bodyB.node == player && contact.bodyA.node == enemy
            {
                gameOver = true
            }
        }
    }
    
    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "restart_button")
        restartBtn.size = CGSize(width:100, height:100)
        restartBtn.position = CGPoint(x: 0, y: 0)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
    }
    
    func restartScene() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            player.run(SKAction.move(to: t.location(in: self), duration: 0.1))
        }
        if gameStopped == true {
            for t in touches {
                let location = t.location(in: self)
                if restartBtn.contains(location) {
                    restartBtn.run(SKAction.scale(to: 0.0, duration: 0.3))
                    gameStopped = false
                    player.physicsBody?.isDynamic = true
                    player.physicsBody?.affectedByGravity = false
                    enemy.physicsBody?.isDynamic = true
                    player.position = CGPoint(x: 0, y: 0)
                    enemy.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    enemy.position = CGPoint(x: -250, y: 500)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            player.run(SKAction.move(to: t.location(in: self), duration: 0.1))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameOver == true {
            restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
            gameOver = false
            gameStopped = true
            player.physicsBody?.isDynamic = false
            enemy.physicsBody?.isDynamic = false
        }
    }
}
