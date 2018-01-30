//
//  levelEnd_1.swift
//  Maze
//
//  Created by Siming You on 11/30/17.
//  Copyright © 2017 Siming You. All rights reserved.
//

import UIKit
import SpriteKit

class levelEnd_1: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "mainMenu" {
                if let scene = MainMenu(fileNamed: "MainMenuScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                }
            }
            if atPoint(location).name == "nextLV" {
                if let scene = normal_2(fileNamed: "normal_2Scene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}

