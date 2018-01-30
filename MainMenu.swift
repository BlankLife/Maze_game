//
//  MainMenu.swift
//  Maze
//
//  Created by Siming You on 10/22/17.
//  Copyright © 2017 Siming You. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    var inst = SKSpriteNode(imageNamed: "instruction")
    var resume = SKSpriteNode()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "normalMode" {
                if let scene = normal_0(fileNamed: "normal_0Scene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                }
            }
            
            if atPoint(location).name == "endlessMode" {
                if let scene = endless(fileNamed: "endlessScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                }
            }
            
            if atPoint(location).name == "instruction" {
                inst.size = CGSize(width: 792, height: 1408)
                inst.position = CGPoint(x: 0, y: -60)
                addChild(inst)
                resume.color = UIColor.white
                resume.alpha = CGFloat(0.1)
                resume.size = CGSize(width:360, height:75)
                resume.position = CGPoint(x: 10, y: -285)
                addChild(resume)
            }
            
            if atPoint(location) == self.resume {
                inst.removeFromParent()
                resume.removeFromParent()
            }
        }
        
    }
    

}
