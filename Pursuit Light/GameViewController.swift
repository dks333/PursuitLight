//
//  GameViewController.swift
//  Pursuit Light
//
//  Created by Sam Ding on 2/17/18.
//  Copyright © 2018 Sam Ding. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class GameViewController: UIViewController {


    public override func viewDidLoad() {
            super.viewDidLoad()
            
            
            if let skview = self.view as! SKView? {
                // Configure the view.
                if let scene = GameScene(fileNamed: "GameScene"){
                    /* Set the scale mode to scale to fit the window */
                    scene.scaleMode = .aspectFill
                    
                    scene.size = skview.bounds.size
                    
                    skview.presentScene(scene)
                }
                //skview.showsFPS = true
                //skview.showsNodeCount = true
                //skview.showsPhysics = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skview.ignoresSiblingOrder = true
                
            }
        }
        
    public override var shouldAutorotate: Bool {
            return true
        }
        
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .allButUpsideDown
            } else {
                return .all
            }
        }
        
    public override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Release any cached data, images, etc that aren't in use.
        }
        
    public override var prefersStatusBarHidden: Bool {
            return true
        }
}

