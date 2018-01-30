//
//  endless.swift
//  Maze
//
//  Created by Jianwei Hu on 11/11/17.
//  Copyright © 2017 Jianwei Hu. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion


class endless: SKScene,SKPhysicsContactDelegate{
    
    var background : SKSpriteNode?
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var pauseMenu = SKSpriteNode(imageNamed: "pause_menu")
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
        //making the frame of the maze
        var x_StartPosition, x_position, y_position, x_inc, y_inc : CGFloat
        var randomNumber = arc4random_uniform(5)
        var index : UInt32

        self.physicsWorld.contactDelegate = self
        
        //player = self.childNode(withName: "player") as! SKSpriteNode
        
       // 
        var background = SKSpriteNode(imageNamed: "download")
        background.size = CGSize(width: self.size.width/20, height: self.size.height)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: -self.size.width/2 + background.size.width/2, y: 0)
        background.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
            width: self.size.width/20,
            height: self.size.height))
        background.physicsBody?.affectedByGravity = false
        background.physicsBody?.isDynamic = false
        background.physicsBody?.categoryBitMask = 27
        background.physicsBody?.collisionBitMask = 25
        background.physicsBody?.fieldBitMask = 1
        background.physicsBody?.contactTestBitMask = 44
        self.addChild(background)
        
        background = SKSpriteNode(imageNamed: "download")
        background.size = CGSize(width: self.size.width/20, height: self.size.height)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: self.size.width/2-background.size.width + background.size.width/2, y: 0)
        background.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
            width: self.size.width/20,
            height: self.size.height))
        background.physicsBody?.affectedByGravity = false
        background.physicsBody?.isDynamic = false
        background.physicsBody?.categoryBitMask = 27
        background.physicsBody?.collisionBitMask = 25
        background.physicsBody?.fieldBitMask = 1
        background.physicsBody?.contactTestBitMask = 44
        self.addChild(background)
                
        
        x_inc = (self.size.width  - 2 * background.size.width)/5
        y_inc = self.size.height/13
        x_position = -self.size.width/2 + background.size.width + x_inc/2
        x_StartPosition = -self.size.width/2 + background.size.width + x_inc/2
        y_position = self.size.height/2 - y_inc/2
        index = 0
     
        let cgfloat = CGFloat(randomNumber)
      
        
        player.position = CGPoint(x: (x_StartPosition + cgfloat * x_inc + x_inc/2), y:
            y_position)
       // player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
        
        
        for _ in 0...34 {
            if randomNumber == index {
                //update x,y position and index, then skip
                if index == 4{
                    index = 0
                    x_position = x_StartPosition
                    y_position -= (2 * y_inc)
                    randomNumber = arc4random_uniform(5)
                }
                else{
                    index += 1
                    x_position += x_inc
                }
            }else{
                if index == 4{
                    background = SKSpriteNode(imageNamed: "download")
                    background.size = CGSize(width: x_inc, height: y_inc)
                    background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    background.position = CGPoint(x: x_position, y: y_position)
                    
                    background.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
                        width: x_inc,
                        height: y_inc))
                    
                    background.physicsBody?.affectedByGravity = false
                    background.physicsBody?.isDynamic = false
                    background.physicsBody?.categoryBitMask = 27
                    background.physicsBody?.collisionBitMask = 25
                    background.physicsBody?.fieldBitMask = 1
                    background.physicsBody?.contactTestBitMask = 44
                    
                    self.addChild(background)
                    index = 0
                    x_position = x_StartPosition
                    y_position -= (2 * y_inc)
                    randomNumber = arc4random_uniform(5)
                }
                else{
                    background = SKSpriteNode(imageNamed: "download")
                    background.size = CGSize(width: x_inc, height: y_inc)
                    background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    background.position = CGPoint(x: x_position, y: y_position)
                    
                    background.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
                        width: x_inc,
                        height: y_inc))
                    
                    background.physicsBody?.affectedByGravity = false
                    background.physicsBody?.isDynamic = false
                    background.physicsBody?.categoryBitMask = 27
                    background.physicsBody?.collisionBitMask = 25
                    background.physicsBody?.fieldBitMask = 1
                    background.physicsBody?.contactTestBitMask = 44
                    
                    self.addChild(background)
                    index += 1
                    x_position += x_inc
                }
            }
        }
        
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
            if let scene = endless(fileNamed: "endless") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(0.01)))
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "pause_button" {
                pauseMenu.size = CGSize(width: 752, height: 1333)
                pauseMenu.zPosition = 5
                addChild(pauseMenu)
                
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
                pauseMenu.removeFromParent()
                resume_button.removeFromParent()
                main_button.removeFromParent()
                self.run(SKAction.run {
                    self.resumeGame()
                })
            }
            if atPoint(location) == self.main_button{
                pauseMenu.removeFromParent()
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
