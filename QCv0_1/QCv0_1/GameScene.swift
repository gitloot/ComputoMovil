//
//  GameScene.swift
//  QCv0_1
//
//  Created by 2020-1 on 9/25/19.
//  Copyright © 2019 Conde. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    //let player = [UIImage animatedImageNamed:@"demon-idle" duration 1.0f]
    private var player = SKSpriteNode()
    private var playerFrames: [SKTexture] = []
    private var playerPos = CGPoint()
    private var background = SKSpriteNode()
    private var music = SKAudioNode()
    private var ini:Bool = false
    private var timeAction:TimeInterval = 0
    
    //SKSpriteNode(imageNamed: "player")
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: " Label") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        //backgroundColor = UIColor(patternImage: UIImage(named: "Background1")!)
        
        background = SKSpriteNode(imageNamed: "Background1")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1.0
        addChild(background)
        
        
        music = SKAudioNode(fileNamed: "864655_Exodus-The-Alpha-Axiom-EP.mp3")
        addChild(music)
        
        
        let skull1 = SKSpriteNode(imageNamed: "Skull")
        skull1.position = CGPoint(x:frame.midX - 50, y:frame.maxY - 100)
        skull1.name = "Skull1"
        addChild(skull1)
        let skull2 = SKSpriteNode(imageNamed: "Skull")
        skull2.position = CGPoint(x:frame.midX, y:frame.maxY - 100)
        skull2.name = "Skull2"
        addChild(skull2)
        let skull3 = SKSpriteNode(imageNamed: "Skull")
        skull3.position = CGPoint(x:frame.midX + 50, y:frame.maxY - 100)
        skull3.name = "Skull3"
        addChild(skull3)
        
        buildPlayer()
        animatePlayer()
        
        playerPos = player.position
        
        generateEnemy1(number: 5)
        timeAction += 5
        generateEnemy2(number: 5)
        timeAction += 10
        generateEnemy3(number: 5)
        timeAction += 5
        generateEnemy4(number: 5)
        timeAction += 10
        boss1Phase1(time: timeAction)
        timeAction += 26.5
        timeAction += 1
        boss1Phase2(time: timeAction)
        fire(time: timeAction, dir: CGPoint(x:frame.minX-50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX+50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 1
        fire(time: timeAction, dir: CGPoint(x:frame.minX+50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX-50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 1
        fire(time: timeAction, dir: CGPoint(x:frame.minX-100 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX+100 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 3
        fire(time: timeAction, dir: CGPoint(x:frame.minX-50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX+50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 1
        fire(time: timeAction, dir: CGPoint(x:frame.minX+50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX-50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 1
        fire(time: timeAction, dir: CGPoint(x:frame.minX-100 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX+100 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 3
        fire(time: timeAction, dir: CGPoint(x:frame.minX-50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX+50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 1
        fire(time: timeAction, dir: CGPoint(x:frame.minX+50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX-50 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 1
        fire(time: timeAction, dir: CGPoint(x:frame.minX-100 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.maxX+100 ,y:frame.minY+100))
        fire(time: timeAction, dir: CGPoint(x:frame.midX , y:frame.minY-100))
        timeAction += 13.5
        buildBoss1Phase3(time: timeAction)
        timeAction+=2
        firePilar(time: timeAction, dir: CGPoint(x:frame.midX,y:frame.midY))
        timeAction+=4
        firePilar(time: timeAction, dir: CGPoint(x:frame.maxX - 100, y: frame.midY))
        timeAction+=3
        firePilar(time: timeAction,dir: CGPoint(x:frame.minX + 100, y: frame.midY))
        timeAction += 2
        credits(time: timeAction)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print("The \(contact.bodyA.node!.name!) entered in contact with the \(contact.bodyB.node!.name!)")
        if contact.bodyA.node!.name == "Player" || contact.bodyB.node!.name == "Player"{
            if let child = self.childNode(withName: "Skull3") as? SKSpriteNode {
                child.removeFromParent()
            }
            else if let child = self.childNode(withName: "Skull2") as? SKSpriteNode {
                child.removeFromParent()
            }else if let child = self.childNode(withName: "Skull1") as? SKSpriteNode {
                child.removeFromParent()
            }else if let child = self.childNode(withName: "Player") as? SKSpriteNode {
                child.removeFromParent()
                let gameOver = SKSpriteNode(imageNamed: "GameOver")
                gameOver.position = CGPoint(x:frame.midX, y:frame.midY)
                gameOver.scale(to: CGSize(width: frame.width, height: frame.width))
                addChild(gameOver)
            }
        }
    }
    
    
    func buildPlayer() {
        let playerAnimatedAtlas = SKTextureAtlas(named: "PlayerImages")
        var frames: [SKTexture] = []
        
        let numImages = playerAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let playerTextureName = "demon-idle\(i)"
            frames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        playerFrames = frames
        let firstFrameTexture = playerFrames[0]
        player = SKSpriteNode(texture: firstFrameTexture)
        
        player.scale(to: CGSize(width: 100.0, height: 100.0))
        
        player.position = CGPoint(x: frame.midX, y: frame.minY+100.0)
        player.zPosition = 1.0
        
        player.name = "Player"
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height/5)
        while(player.physicsBody == nil){
            
        }
        player.physicsBody!.isDynamic = true
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = CategoryMask.player.rawValue
        player.physicsBody!.collisionBitMask = CategoryMask.enemy.rawValue
        player.physicsBody!.contactTestBitMask = CategoryMask.enemy.rawValue
        
        addChild(player)
    }
    
    func animatePlayer() {
        player.run(SKAction.repeatForever(
            SKAction.animate(with: playerFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"movedPlacePlayer")
    }
    
    
    func boss1Phase1(time : TimeInterval){
        let enemy = SKSpriteNode(imageNamed: "Boss1Phase1")
        enemy.position = CGPoint(x: frame.midY, y: frame.maxY + 50)
        enemy.zPosition = 0.0
        enemy.name = "Boss1"
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height/4)
        enemy.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.isDynamic = false
        //enemy.physicsBody!.collisionBitMask = CategoryMask.player.rawValue
        //enemy.physicsBody!.contactTestBitMask = CategoryMask.player.rawValue
        let waitAction = SKAction.wait(forDuration: time)
        let moveEnemy = SKAction.move(to: CGPoint(x:frame.midX, y: frame.midY), duration: 5)
        let scaleEnemy = SKAction.scale(by: 5, duration: 2.5)
        let moveEnemy2 = SKAction.move(to: CGPoint(x:frame.midX , y:frame.minY + 200), duration: 1)
        let moveEnemy3 = SKAction.move(to: CGPoint(x:frame.maxX - 50, y:frame.maxY - 100), duration: 2)
        let moveEnemy4 = SKAction.move(to: CGPoint(x:frame.minX + 100, y:frame.minY + 200), duration: 1)
        let moveEnemy5 = SKAction.move(to: CGPoint(x:frame.maxX - 100, y:frame.minY + 200), duration: 1)
        let moveEnemy6 = SKAction.move(to: CGPoint(x:frame.minX + 50, y:frame.maxY - 100), duration: 2)
        let moveEnemy7 = SKAction.move(to: CGPoint(x:frame.midX, y: frame.midY), duration: 2)
        let stop = SKAction.stop()
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence =  SKAction.sequence(
            [waitAction, moveEnemy, stop, scaleEnemy, moveEnemy2, //8.5
             moveEnemy3, moveEnemy4, moveEnemy5, moveEnemy6, moveEnemy5, //7
             moveEnemy4, moveEnemy3, moveEnemy4, moveEnemy5, moveEnemy6, //7
             moveEnemy5, moveEnemy4, moveEnemy7, deleteEnemy]) //4
        enemy.run(enemySequence)
        self.addChild(enemy)
    }
    
    func boss1Phase2(time : TimeInterval){
        let enemy = SKSpriteNode(imageNamed: "Boss1Phase2")
        enemy.position = CGPoint(x: frame.midY, y: frame.maxY + 50)
        enemy.zPosition = 0.0
        enemy.name = "Boss1"
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height/4)
        enemy.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.isDynamic = false
        //enemy.physicsBody!.collisionBitMask = CategoryMask.player.rawValue
        //enemy.physicsBody!.contactTestBitMask = CategoryMask.player.rawValue
        let waitAction = SKAction.wait(forDuration: time)
        let moveEnemy = SKAction.move(to: CGPoint(x:frame.midX, y: frame.midY), duration: 0)
        let scaleEnemy = SKAction.scale(by: 5, duration: 0)
        let moveEnemy2 = SKAction.move(to: CGPoint(x:frame.midX , y:frame.minY + 200), duration: 1)
        let moveEnemy3 = SKAction.move(to: CGPoint(x:frame.maxX - 50, y:frame.maxY - 100), duration: 2)
        let moveEnemy4 = SKAction.move(to: CGPoint(x:frame.minX + 100, y:frame.minY + 200), duration: 1)
        let moveEnemy5 = SKAction.move(to: CGPoint(x:frame.maxX - 100, y:frame.minY + 200), duration: 1)
        let moveEnemy6 = SKAction.move(to: CGPoint(x:frame.minX + 50, y:frame.maxY - 100), duration: 2)
        let moveEnemy7 = SKAction.move(to: CGPoint(x:frame.midX, y: frame.midY), duration: 2)
        let stop = SKAction.stop()
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence =  SKAction.sequence([waitAction, moveEnemy, stop, scaleEnemy, moveEnemy2, moveEnemy3, moveEnemy4, moveEnemy5, moveEnemy6, moveEnemy5, moveEnemy4, moveEnemy3, moveEnemy4, moveEnemy5, moveEnemy6, moveEnemy5, moveEnemy4, moveEnemy7, deleteEnemy])
        enemy.run(enemySequence)
        self.addChild(enemy)
    }
    
    func buildBoss1Phase3(time: TimeInterval) {
        let bossAnimatedAtlas = SKTextureAtlas(named: "Boss1Images")
        var frames: [SKTexture] = []
        
        let numImages = 4//bossAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let bossTextureName = "hell-beast-burn\(i)"
            frames.append(bossAnimatedAtlas.textureNamed(bossTextureName))
        }
        let boss1Frames = frames
        let firstFrameTexture = boss1Frames[0]
        let boss1 = SKSpriteNode(texture: firstFrameTexture)
        
        boss1.scale(to: CGSize(width: 500.0, height: 500.0))
        
        boss1.position = CGPoint(x: frame.maxX+100, y: frame.maxY+100)
        boss1.zPosition = 1.0
        
        boss1.name = "Boss"
        boss1.physicsBody = SKPhysicsBody(circleOfRadius: boss1.size.height/5)
        while(boss1.physicsBody == nil){
            
        }
        boss1.physicsBody!.isDynamic = false
        boss1.physicsBody!.affectedByGravity = false
        boss1.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        //boss1.physicsBody!.collisionBitMask = CategoryMask.enemy.rawValue
        //boss1.physicsBody!.contactTestBitMask = CategoryMask.enemy.rawValue
        let boss1Wait = SKAction.wait(forDuration: time)
        let boss1Animate = SKAction.animate(with: boss1Frames, timePerFrame: 0.5,resize: false,restore: true)
        let boss1Move = SKAction.move(to: CGPoint(x:frame.midX, y: frame.midY), duration: 0)
        let boss1Move2 = SKAction.move(to: CGPoint(x:frame.minX + 100, y: frame.midY), duration: 1)
        let boss1Move3 = SKAction.move(to: CGPoint(x:frame.maxX - 100, y: frame.midY), duration: 1)
        let boss1Delete = SKAction.removeFromParent()
        let boss1Sequence = SKAction.sequence([boss1Wait,boss1Move,boss1Animate,boss1Move2,boss1Move3,boss1Animate,boss1Move2,boss1Animate,boss1Move,boss1Animate,boss1Delete])
        
        boss1.run(boss1Sequence)
        
        self.addChild(boss1)
    }
    
    func fire(time: TimeInterval, dir: CGPoint){
        let enemy = SKSpriteNode(imageNamed: "FireBall")
        enemy.position = CGPoint(x: frame.midX, y: frame.maxY+100)
        enemy.zPosition = 0.0
        enemy.scale(to: CGSize(width: 100.0, height: 100.0))
        enemy.name = "enemy"
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height/5)
        enemy.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.isDynamic = false
        let waitAction = SKAction.wait(forDuration: time)
        let moveEnemy = SKAction.move(to: CGPoint(x:frame.midX, y: frame.midY), duration: 0)
        let moveEnemy2 = SKAction.move(to: dir, duration: 1)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([waitAction, moveEnemy, moveEnemy2, deleteEnemy])
        enemy.run(enemySequence)
        self.addChild(enemy)
    }
    
    func firePilar(time:TimeInterval, dir: CGPoint){
        let enemy = SKSpriteNode(imageNamed: "FirePilar")
        enemy.position = CGPoint(x: frame.minX-500, y: 0)
        enemy.zPosition = 2.0
        enemy.scale(to: CGSize(width: 100.0, height: frame.size.height))
        enemy.name = "enemy"
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height/5)
        enemy.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.isDynamic = false
        let waitAction = SKAction.wait(forDuration: time)
        let waitAction2 = SKAction.wait(forDuration: 2)
        let move = SKAction.move(to: dir, duration: 0)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([waitAction,move,waitAction2,deleteEnemy])
        enemy.run(enemySequence)
        self.addChild(enemy)
    }
    
    func enemy1(time: TimeInterval){
        let enemy = SKSpriteNode(imageNamed: "Ghost1")
        enemy.position = CGPoint(x: frame.maxX,y: frame.maxY)
        enemy.zPosition = 0.0
        enemy.scale(to: CGSize(width: 75.0, height: 75.0))
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height/5)
        enemy.name = "Enemy1"
        enemy.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.isDynamic = false
        //enemy.physicsBody!.collisionBitMask = CategoryMask.player.rawValue
        //enemy.physicsBody!.contactTestBitMask = CategoryMask.player.rawValue
        let waitAction = SKAction.wait(forDuration: time)
        let moveEnemy = SKAction.move(to: CGPoint(x:frame.midX, y: frame.minY + 100), duration: 5)
        //let stop = SKAction.stop()
        let moveEnemy2 = SKAction.move(to: CGPoint(x:frame.minX - 100, y: frame.minY + 100), duration: 5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([waitAction, moveEnemy, moveEnemy2, deleteEnemy])//deleteEnemy])
        enemy.run(enemySequence)
        self.addChild(enemy)
    }
    
    func enemy2(time:TimeInterval){
        let enemy = SKSpriteNode(imageNamed: "Ghost1")
        enemy.position = CGPoint(x: frame.minX,y: frame.maxY)
        enemy.zPosition = 0.0
        enemy.scale(to: CGSize(width: 75.0, height: 75.0))
        enemy.xScale = abs(enemy.xScale) * -1.0
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height/5)
        enemy.name = "Enemy2"
        enemy.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.isDynamic = false
        //enemy.physicsBody!.collisionBitMask = CategoryMask.player.rawValue
        //enemy.physicsBody!.contactTestBitMask = CategoryMask.player.rawValue
        let waitAction = SKAction.wait(forDuration: time)
        let moveEnemy = SKAction.move(to: CGPoint(x:frame.midX, y: frame.minY + 100), duration: 5)
        //let stop = SKAction.stop()
        let moveEnemy2 = SKAction.move(to: CGPoint(x:frame.maxX + 100, y: frame.minY + 100), duration: 5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([waitAction, moveEnemy, moveEnemy2, deleteEnemy])//deleteEnemy])
        enemy.run(enemySequence)
        self.addChild(enemy)
    }
    
    func enemy3(time: TimeInterval){
        let enemy = SKSpriteNode(imageNamed: "Ghost2")
        enemy.position = CGPoint(x: frame.minX,y: frame.maxY)
        enemy.zPosition = 0.0
        enemy.scale(to: CGSize(width: 75.0, height: 75.0))
        enemy.xScale = abs(enemy.xScale) * -1.0
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height/5)
        enemy.name = "Enemy2"
        enemy.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.isDynamic = false
        //enemy.physicsBody!.collisionBitMask = CategoryMask.player.rawValue
        //enemy.physicsBody!.contactTestBitMask = CategoryMask.player.rawValue
        let waitAction = SKAction.wait(forDuration: time)
        let moveEnemy = SKAction.move(to: CGPoint(x:frame.maxX - 50, y: frame.minY + 100), duration: 5)
        //let stop = SKAction.stop()
        let moveEnemy2 = SKAction.move(to: CGPoint(x:frame.midX, y: frame.midY), duration: 5)
        let moveEnemy3 = SKAction.move(to: CGPoint(x:frame.minX + 50, y: frame.minY + 100), duration: 5)
        let moveEnemy4 = SKAction.move(to: CGPoint(x:frame.maxX - 50 , y: frame.maxY + 100), duration: 5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([waitAction, moveEnemy, moveEnemy2, moveEnemy3, moveEnemy4, deleteEnemy])//deleteEnemy])
        enemy.run(enemySequence)
        self.addChild(enemy)
    }
    
    func enemy4(time: TimeInterval){
        let enemy = SKSpriteNode(imageNamed: "Ghost2")
        enemy.position = CGPoint(x: frame.maxX,y: frame.maxY)
        enemy.zPosition = 0.0
        enemy.scale(to: CGSize(width: 75.0, height: 75.0))
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.height/5)
        enemy.name = "Enemy2"
        enemy.physicsBody!.categoryBitMask = CategoryMask.enemy.rawValue
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.isDynamic = false
        //enemy.physicsBody!.collisionBitMask = CategoryMask.player.rawValue
        //enemy.physicsBody!.contactTestBitMask = CategoryMask.player.rawValue
        let waitAction = SKAction.wait(forDuration: time)
        let moveEnemy = SKAction.move(to: CGPoint(x:frame.minX + 50, y: frame.minY + 100), duration: 5)
        //let stop = SKAction.stop()
        let moveEnemy2 = SKAction.move(to: CGPoint(x:frame.midX, y: frame.midY), duration: 5)
        let moveEnemy3 = SKAction.move(to: CGPoint(x:frame.maxX - 50, y: frame.minY + 100), duration: 5)
        let moveEnemy4 = SKAction.move(to: CGPoint(x:frame.minX + 50 , y: frame.maxY + 100), duration: 5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([waitAction, moveEnemy, moveEnemy2, moveEnemy3, moveEnemy4, deleteEnemy])//deleteEnemy])
        enemy.run(enemySequence)
        self.addChild(enemy)
    }

    func generateEnemy1(number : Int){
        for i in 1...number{
            enemy1(time: TimeInterval(i))
        }
    }
    
    func generateEnemy2(number: Int){
        for i in 1...number{
            enemy2(time: TimeInterval(i) + timeAction)
        }
    }
    
    func generateEnemy3(number: Int){
        for i in 1...number{
            enemy3(time: TimeInterval(i) + timeAction)
        }
    }
    
    func generateEnemy4(number: Int){
        for i in 1...number{
            enemy4(time: TimeInterval(i) + timeAction)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            if(playerPos.x > pos.x){
                player.xScale = abs(player.xScale) * 1.0
            }else if(playerPos.x < pos.x){
                player.xScale = abs(player.xScale) * -1.0
            }
            player.position.y = playerPos.y
            playerPos.x = pos.x
            player.position.x = pos.x
            n.strokeColor = SKColor.cyan
            self.addChild(n)
        }
    }
    
    func credits(time: TimeInterval){
        let credits = SKSpriteNode(imageNamed: "Credits")
        credits.position = CGPoint(x:frame.maxX + 500, y:frame.maxY + 500)
        credits.scale(to: CGSize(width: frame.width, height: frame.width))
        let waitAction = SKAction.wait(forDuration: time)
        let moveToCenter = SKAction.move(to: CGPoint(x:frame.midX, y:frame.midY), duration: 0)
        let stop = SKAction.stop()
        let creditsSequence = SKAction.sequence([waitAction, moveToCenter, stop])
        credits.run(creditsSequence)
        self.addChild(credits)
    }
    
    /*func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }*/
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }*/
    
    /*func touchDown(atPoint pos : CGPoint) {
     if let n = self.spinnyNode?.copy() as! SKShapeNode? {
     n.position = pos
     n.strokeColor = SKColor.green
     self.addChild(n)
     }
     }*/
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
        }
    }
    
    /*override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        print("Final de un toque")
    }*/
    
    /*override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }*/
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

enum CategoryMask:UInt32{
    case player = 0b01
    case playerBullet = 0b10
    case enemy = 0b11
}
