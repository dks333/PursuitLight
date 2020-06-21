//
//  GameView.swift
//  Pursuit Light
//
//  Created by Sam Ding on 4/1/18.
//  Copyright © 2018 Sam Ding. All rights reserved.
//

import Foundation
import  UIKit
import SpriteKit
import AVFoundation

extension UIView{
    func fadeOut() {
        UIView.animate(withDuration: 1, delay: 2.0, options: UIView.AnimationOptions.curveEaseOut, animations:{
            self.alpha = 0.0
        }, completion: nil)
    }
    
}


 class GameView : UIViewController{
    
    var audioPlayer = AVAudioPlayer(){
        didSet{
            self.audioPlayer.pause()
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) {
                [weak self]timer in
                self?.audioPlayer.play()
        }
        }
    }
    @IBOutlet var PursuitLightBG: UIImageView!
    @IBOutlet var MusicBtn: UIButton!
    @IBOutlet var PursuitLightTitle: UILabel!
    @IBOutlet var BG: UIImageView!
    @IBOutlet var HighestScoreLB: UILabel!
    @IBOutlet var StartBtn: UIButton!{
        didSet{
            self.StartBtn.isEnabled = false
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) {
            [weak self]timer in
            self?.StartBtn.isEnabled = true
            }
        }}
    
     override func viewDidLoad() {
        super.viewDidLoad()
        BG.frame = self.view.bounds
        PursuitLightBG.frame = self.view.bounds
        BG.clipsToBounds = true
        PursuitLightBG.clipsToBounds = true
        self.BG.fadeOut()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "GameBG", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
        } catch {
            print("Cannot play the file")
        }
        audioPlayer.play()
        
       
        self.navigationController?.navigationBar.isHidden = true
        self.HighestScoreLB.center = CGPoint(x:self.view.bounds.width/2 ,y: (self.view.bounds.height/4) )
        self.StartBtn.center = CGPoint(x:self.view.bounds.width/2 ,y: (self.view.bounds.height/4)*3 )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.integer(forKey: "Key")
        HighestScoreLB.text = "Higheset: \(value)"
    }
    
    @IBAction func MusicPlayOnOff(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }else{
            audioPlayer.play()
        }
        
    }
    @IBAction func Start(_ sender: Any) {
        StartTheGame()
    }
    
    func StartTheGame(){
        DispatchQueue.main.async() {
            self.audioPlayer.pause()
        }
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        
        let game = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameViewController
        self.view.window?.rootViewController = game
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
}
