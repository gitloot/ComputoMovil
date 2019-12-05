//
//  MenuScene.swift
//  QCv0_1
//
//  Created by 2020-1 on 12/3/19.
//  Copyright © 2019 Conde. All rights reserved.
//
/*
import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var playButton = SKSpriteNode()
    let playButtonTex = SKTexture(imageNamed: "Play")
    
    override func didMove(to view: SKView) {
        
        playButton = SKSpriteNode(texture: playButtonTex)
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(playButton)
        
        backgroundColor = .black
        
        print("View")
        
        func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
            if let touch = touches.first as? UITouch {
                let pos = touch.location(in: self)
                let node = self.atPoint(pos)
                
                if node == playButton {
                    let scene = GameScene.init(fileNamed: "GameScene") as! GameScene
                    scene.scaleMode = SKSceneScaleMode.aspectFill
                    view.presentScene(scene)
                }
            }
        }
    }
}*/
