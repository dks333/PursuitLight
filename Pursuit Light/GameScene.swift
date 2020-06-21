//
//  GameScene.swift
//  Pursuit Light
//
//  Created by Sam Ding on 2/17/18.
//  Copyright © 2018 Sam Ding. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import UIKit
import AVKit


public class GameScene: SKScene {
    
    var player = SKSpriteNode()
    var spinnyNode : SKShapeNode?
    var blockOne = SKSpriteNode()
    var blockTwo = SKSpriteNode()
    var blockThree = SKSpriteNode()
    var blockFour = SKSpriteNode()
    
    var mainCamera = SKCameraNode()
    var scoreLB = SKLabelNode()
    var score = Int()
    var highestScore = SKLabelNode()
    var alternateScore = Int()
    var playerHeight = CGFloat()
    var lastHeight = CGFloat()
    var tutorial = SKLabelNode()
    var tutorialDisappear = Bool(false)
    
    var audioPlayer = AVAudioPlayer()
    
    var startPressingTime : TimeInterval?
    
    var background = SKSpriteNode()
    var backgroundOne = SKSpriteNode()
    var backgroundTwo = SKSpriteNode()
    var backgroundThree = SKSpriteNode()

    var left = Bool(false)
    let longPress = UILongPressGestureRecognizer()
    
    struct leftIsFalse {
        static var left : Bool = false
    }
    
    struct game{
        static var IsOver : Bool = false
    }
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        createScene()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "JumpMusicFinal", ofType: "aifc")!))
            audioPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        
        
        //player setting
        player = SKSpriteNode(color: SKColor.white, size:CGSize(width: 30, height: 30))
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.angularDamping = 0
        player.position = CGPoint(x:-self.frame.width/4,y:0-self.frame.height/2 + player.size.height/2)
        player.physicsBody?.friction = 1
        player.physicsBody?.mass = 0.0400000028312206
        player.physicsBody?.isDynamic = true
        player.physicsBody?.angularDamping = 0
        player.physicsBody?.linearDamping = 1
        player.physicsBody?.categoryBitMask = 4294967295
        player.physicsBody?.collisionBitMask = 4294967295
        player.physicsBody?.fieldBitMask = 4294967295
        player.physicsBody?.contactTestBitMask = 0
        addChild(player)
        
        blockOne = SKSpriteNode(color: SKColor.black, size:CGSize(width: 100, height: 70))
        blockOne.physicsBody = SKPhysicsBody(rectangleOf: blockOne.size)
        blockOne.position = CGPoint(x:self.frame.width/2 - blockOne.size.width/2,y:-(self.frame.height/4))
        blockOne.physicsBody?.friction = 1
        blockOne.physicsBody?.isDynamic = false
        blockOne.physicsBody?.categoryBitMask = 4294967295
        blockOne.physicsBody?.collisionBitMask = 4294967295
        blockOne.physicsBody?.fieldBitMask = 4294967295
        blockOne.physicsBody?.contactTestBitMask = 0
        blockTwo = SKSpriteNode(color: SKColor.black, size:CGSize(width: 100, height: 70))
        blockTwo.position = CGPoint(x:0 - self.frame.width/2 + blockTwo.size.width/2,y:self.frame.height/6)
        blockTwo.physicsBody = SKPhysicsBody(rectangleOf: blockTwo.size)
        blockTwo.physicsBody?.friction = 1
        blockTwo.physicsBody?.isDynamic = false
        blockTwo.physicsBody?.categoryBitMask = 4294967295
        blockTwo.physicsBody?.collisionBitMask = 4294967295
        blockTwo.physicsBody?.fieldBitMask = 4294967295
        blockThree.physicsBody?.contactTestBitMask = 0
        blockThree = SKSpriteNode(color: SKColor.black, size:CGSize(width: 100, height: 70))
        blockThree.position = CGPoint(x:self.frame.width/2 - blockThree.size.width/2,y:(self.frame.height/3)*2)
        blockThree.physicsBody = SKPhysicsBody(rectangleOf: blockThree.size)
        blockThree.physicsBody?.friction = 1
        blockThree.physicsBody?.isDynamic = false
        blockThree.physicsBody?.categoryBitMask = 4294967295
        blockThree.physicsBody?.collisionBitMask = 4294967295
        blockThree.physicsBody?.fieldBitMask = 4294967295
        blockThree.physicsBody?.contactTestBitMask = 0
        blockFour = SKSpriteNode(color: SKColor.black, size:CGSize(width: 100, height: 70))
        blockFour.physicsBody = SKPhysicsBody(rectangleOf: blockFour.size)
        blockFour.position = CGPoint(x:0 - self.frame.width/2 + blockOne.size.width/2,y:(self.frame.height/4)*5)
        blockFour.physicsBody?.friction = 1
        blockFour.physicsBody?.isDynamic = false
        blockFour.physicsBody?.categoryBitMask = 4294967295
        blockFour.physicsBody?.collisionBitMask = 4294967295
        blockFour.physicsBody?.fieldBitMask = 4294967295
        blockFour.physicsBody?.contactTestBitMask = 0
        addChild(blockOne)
        addChild(blockTwo)
        addChild(blockThree)
        addChild(blockFour)
        

        longPress.addTarget(self, action: #selector(GameScene.LongPress(recognizer:)))
        longPress.numberOfTouchesRequired = 1
        longPress.numberOfTapsRequired = 0
        longPress.minimumPressDuration = 0.000000000001
        self.view?.addGestureRecognizer(longPress)
        
        
    }
 
    func addScore(){
        
    }
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
           
        
            let location = touch.location(in: self)
            player.physicsBody?.isDynamic = true

            
            /*if location.x < player.position.x {
                player.physicsBody?.applyImpulse(CGVector(dx:-10,dy:30))
                alternateScore = 0
                
            }else {
                player.physicsBody?.applyImpulse(CGVector(dx:10,dy:30))
                alternateScore = 0
            }*/
        }
        
    
    }
    
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        createInfiniteBlock()
        createInfiniteBG()
        if (player.physicsBody?.velocity.dy)! < CGFloat(4.52705535280984e-05) && (player.physicsBody?.velocity.dx)! < CGFloat(4.52705535280984e-05) {
            longPress.isEnabled = true
            player.color = SKColor.white
        }else{
            player.color = SKColor.cyan
            longPress.isEnabled = false
        }
        if player.size.height < 5{
            player.removeAllActions()
        }
       if longPress.state == .began && longPress.state != .ended{
            player.run(SKAction.resize(byWidth: -15, height: -15, duration: 10))

       }else{

            player.removeAllActions()
            player.size.height = 30
            player.size.width = 30
        }
        
        if player.position.y < self.mainCamera.position.y - self.frame.height/2 - 150 {
            player.physicsBody?.isDynamic = false
            self.view?.removeGestureRecognizer(longPress)
            
        }
        if player.position.x < 0 - self.frame.width/2 - 15 || player.position.x > self.frame.width/2 + 15 ||     ((player.physicsBody?.velocity.dy)! < CGFloat(-6.0) && player.position.y < playerHeight){
            self.mainCamera.run(SKAction.move(to: CGPoint(x: 0, y: playerHeight + self.frame.height/2), duration: 0.5))
            self.view?.removeGestureRecognizer(longPress)
            goToGameScene()
            
            let savedScore = score
            let userDefaults = Foundation.UserDefaults.standard
            let value = userDefaults.integer(forKey: "Key")
            if savedScore > value{
                userDefaults.setValue(savedScore, forKey: "Key")
                highestScore.text = "\(savedScore)"
            }
        
            
        }else{
            if player.position.y < -150 {
                self.mainCamera.position.y = 0
            }else {
                self.mainCamera.position.y = player.position.y + 150
                scoreLB.position.y = self.mainCamera.position.y
                if (player.physicsBody?.velocity.dy)! < 0.0 && player.position.y < playerHeight {
                    lastHeight = self.player.position.y
                }
            }
        }
            highestScore.position = CGPoint(x: self.frame.width/2 - self.frame.width/9 ,y: self.frame.height/2 - self.frame.height/12 + self.mainCamera.position.y)
            if tutorialDisappear {
                tutorial.alpha = 0
            }
      
        
    }

    
    func createScene(){
        
        mainCamera = SKCameraNode()
        mainCamera.xScale = 1
        mainCamera.yScale = 1
        self.camera = mainCamera
        addChild(mainCamera)
        
        scoreLB = SKLabelNode(fontNamed: "TR2N")
        scoreLB.position = CGPoint(x: 0, y: 0)
        scoreLB.text = "\(score)"
        scoreLB.fontColor = UIColor.white
        scoreLB.fontSize = 80
        scoreLB.alpha = 0.4
        addChild(scoreLB)
        
        highestScore = SKLabelNode(fontNamed: "TR2N")
        highestScore.position = CGPoint(x: self.frame.width/2 - self.frame.width/9 ,y: self.frame.height/2 - self.frame.height/13)
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "Key")
        highestScore.text = "\(value)"
        highestScore.fontColor = UIColor.white
        highestScore.fontSize = 25
        highestScore.alpha = 0.8
        addChild(highestScore)
        
        
        tutorial = SKLabelNode(fontNamed: "TR2N")
        tutorial.position = CGPoint(x: 0, y: self.frame.height/3)
        tutorial.text = "Long Press"
        tutorial.fontSize = 32
        tutorial.fontColor = UIColor.orange
        addChild(tutorial)
        tutorial.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: self.frame.height/3 + 20, duration: 0.5),SKAction.moveTo(y: self.frame.height/3 - 20, duration: 0.5)])))
        
        
        self.physicsWorld.gravity.dy = -12.0
        playerHeight = player.position.y
        
        let border = SKPhysicsBody(edgeFrom: CGPoint(x: 0-self.frame.width/2, y: 0-self.frame.height/2), to: CGPoint(x: self.frame.width/2, y: 0-self.frame.height/2 ))
        //let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 1
        self.physicsBody = border
        self.physicsBody?.restitution = 0
        
        //PursuitLightBG
        background = SKSpriteNode(imageNamed: "FinalVersionBG")
        background.zPosition = -1
        background.position = CGPoint(x: 0, y: 0)
        background.size = (self.view?.bounds.size)!
        addChild(background)
        
        backgroundOne = SKSpriteNode(imageNamed: "FinalVersionBG")
        backgroundOne.zPosition = -1
        backgroundOne.size = (self.view?.bounds.size)!
        backgroundOne.position = CGPoint(x: 0, y: self.frame.height)
        addChild(backgroundOne)
        
        backgroundTwo = SKSpriteNode(imageNamed: "FinalVersionBG")
        backgroundTwo.zPosition = -1
        backgroundTwo.size = (self.view?.bounds.size)!
        backgroundTwo.position = CGPoint(x: 0, y: self.frame.height*2)
        addChild(backgroundTwo)
        
        backgroundThree = SKSpriteNode(imageNamed: "FinalVersionBG")
        backgroundThree.zPosition = -1
        backgroundThree.size = (self.view?.bounds.size)!
        backgroundThree.position = CGPoint(x: 0, y: self.frame.height*3)
        addChild(backgroundThree)
        
        playerHeight = 0 - self.frame.height/2 + player.size.height/2
        
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max-min)+min
    }
    
    func createInfiniteBG(){
        //background infinity setting:
        if background.position.y + (background.size.height * 2.5) < (mainCamera.position.y) {
            background.position.y += background.size.height * 4
        }
        if backgroundOne.position.y + (background.size.height * 2.5) < (mainCamera.position.y) {
            backgroundOne.position.y += background.size.height * 4
        }
        if backgroundTwo.position.y + (background.size.height * 2.5) < (mainCamera.position.y) {
            backgroundTwo.position.y += background.size.height * 4
        }
        if backgroundThree.position.y + (background.size.height * 2.5) < (mainCamera.position.y) {
            backgroundThree.position.y += background.size.height * 4
        }
    }
    
    func createInfiniteBlock(){
        if player.physicsBody?.velocity.dy == 0.0 && player.position.y - 15 <= blockOne.position.y + 35.5 && player.position.y - 15 >= blockOne.position.y + 34.5 && player.position.y > self.frame.height{
            blockFour.position.y = blockThree.position.y + random(min: self.frame.height/4, max: (self.frame.height/3)*2)
            addScores()
            playerHeight = player.position.y
            

        }
        if player.physicsBody?.velocity.dy == 0.0 && player.position.y - 15 <= blockTwo.position.y + 35.5 && player.position.y - 15 >= blockTwo.position.y + 34.5{
            blockOne.position.y = blockFour.position.y + random(min: self.frame.height/4, max: (self.frame.height/3)*2)
            playerHeight = player.position.y
           addScores()

        }
        if player.physicsBody?.velocity.dy == 0.0 && player.position.y - 15 <= blockThree.position.y + 35.5 && player.position.y - 15 >= blockThree.position.y + 34.5{
            blockTwo.position.y = blockOne.position.y + random(min: self.frame.height/4, max: (self.frame.height/3)*2)
            addScores()
            playerHeight = player.position.y

        }
        if player.physicsBody?.velocity.dy == 0.0 && player.position.y - 15 <= blockFour.position.y + 35.5 && player.position.y - 15 >= blockFour.position.y + 34.5{
            blockThree.position.y = blockTwo.position.y + random(min: self.frame.height/4, max: (self.frame.height/3)*2)
            addScores()
            playerHeight = player.position.y

        }
        if player.physicsBody?.velocity.dy == 0.0 && player.position.y - 15 <= blockOne.position.y + 38 && player.position.y - 15 >= blockOne.position.y + 32 {
            addScores()
            playerHeight = player.position.y
        }
    
    }
    
    
    func addScores(){

        if alternateScore == 0{
            score += 1
            scoreLB.text = "\(score)"
            alternateScore += 1
        }
    }
    
    func movingBlock(block: SKSpriteNode){
        block.run(SKAction.moveTo(x: self.frame.width/2, duration: 2))
    }
    
    // Call back event
    @objc func LongPress(recognizer: UILongPressGestureRecognizer) {
        //recognizer settings
        var gestureTime = Double()
        recognizer.minimumPressDuration = 0.00000000000000001
        recognizer.delaysTouchesBegan = false
        switch recognizer.state {
        case UIGestureRecognizerState.possible:
            player.removeAllActions()
            break
        case UIGestureRecognizerState.began:
            
            startPressingTime = NSDate.timeIntervalSinceReferenceDate
            
            break
        case UIGestureRecognizerState.ended:
            gestureTime = NSDate.timeIntervalSinceReferenceDate - startPressingTime! + recognizer.minimumPressDuration

            let dx = 2 + gestureTime*18
            if left == false {
                player.physicsBody?.applyImpulse(CGVector(dx:2 + gestureTime*15,dy: 10 + gestureTime*56))
                left = true
            }else {
                player.physicsBody?.applyImpulse(CGVector(dx:-(2 + gestureTime*15),dy:10 + gestureTime*56))
                left = false
                
            }
            if dx < 5.0 && dx > -5.0 && player.position.y == playerHeight {
                alternateScore = 1
            } else{
                alternateScore = 0
            }
            audioPlayer.play()
            
            tutorialDisappear = true
            break
        default:
            break
        }
    }
    
    func goToGameScene(){
        let gameScene:GameScene = GameScene(size: self.view!.bounds.size) // create your new scene
        let transition = SKTransition.fade(withDuration: 1.0) // create type of transition (you can check in documentation for more transtions)
        gameScene.scaleMode = SKSceneScaleMode.fill
        self.view!.presentScene(gameScene, transition: transition)
    }
    
    
    
    
    
    
}
