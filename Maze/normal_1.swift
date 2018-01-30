//
//  normal_1.swift
//  Maze
//
//  Created by Siming You on 11/27/17.
//  Copyright © 2017 Siming You. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion


class normal_1: SKScene,SKPhysicsContactDelegate{
    
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var dark = SKSpriteNode()
    var background = SKSpriteNode(imageNamed: "pause_menu")
    var resume_button = SKSpriteNode()
    var main_button = SKSpriteNode()
    let world = SKNode()
    
    func pauseGame() {
        world.isPaused = true
        physicsWorld.speed = 0
    }
    func resumeGame() {
        world.isPaused = false
        physicsWorld.speed = 1
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data: CMAccelerometerData? ,error: Error?) in
            
            self.physicsWorld.gravity = CGVector(dx: (self.manager.accelerometerData?.acceleration.x)! , dy: (self.manager.accelerometerData?.acceleration.y)!)
            
        }
        addChild(world)
        world.addChild(player)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let body1 = contact.bodyA
        let body2 = contact.bodyB
        
        
        if body1.categoryBitMask == 1 && body2.categoryBitMask == 3 ||
            body1.categoryBitMask == 3 && body2.categoryBitMask == 1{
            childNode(withName: "lock")?.removeFromParent()
            childNode(withName: "key")?.removeFromParent()
        }
        if body1.categoryBitMask == 1 && body2.categoryBitMask == 4 ||
            body1.categoryBitMask == 4 && body2.categoryBitMask == 1{
            let nextScene = levelEnd_1(fileNamed: "levelEndScene")
            nextScene?.scaleMode = .aspectFill
            view!.presentScene(nextScene!, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(0.1)))
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "pause_button" {
                background.size = CGSize(width: 752, height: 1333)
                background.zPosition = 5
                addChild(background)
                
                resume_button.color = UIColor.white
                resume_button.alpha = CGFloat(0.1)
                resume_button.size = CGSize(width:465, height:80)
                resume_button.position = CGPoint(x: 2, y: 50)
                resume_button.zPosition = 5
                addChild(resume_button)
                
                main_button.color = UIColor.white
                main_button.alpha = CGFloat(0.1)
                main_button.size = CGSize(width:465, height:80)
                main_button.position = CGPoint(x: 2, y: -77)
                main_button.zPosition = 5
                addChild(main_button)
                
                self.run(SKAction.run {
                    self.pauseGame()
                })
            }
            if atPoint(location) == self.resume_button{
                background.removeFromParent()
                resume_button.removeFromParent()
                main_button.removeFromParent()
                self.run(SKAction.run {
                    self.resumeGame()
                })
            }
            if atPoint(location) == self.main_button{
                background.removeFromParent()
                resume_button.removeFromParent()
                main_button.removeFromParent()
                if let scene = MainMenu(fileNamed: "MainMenuScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}

