//
//  levelEnd_0.swift
//  Maze
//
//  Created by Siming You on 10/28/17.
//  Copyright © 2017 Siming You. All rights reserved.
//

import UIKit
import SpriteKit

class levelEnd_0: SKScene {

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
                if let scene = normal_1(fileNamed: "normal_1Scene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}

