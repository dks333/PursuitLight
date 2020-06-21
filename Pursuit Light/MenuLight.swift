//
//  Menu.swift
//  Pursuit Light
//
//  Created by Sam Ding on 4/1/18.
//  Copyright © 2018 Sam Ding. All rights reserved.
//

import Foundation
import UIKit

class MenuLight: UIViewController {
    
    @IBOutlet var StartBtn: UIButton!
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func Start(_ sender: Any) {
        moveToTheGame()
    }
    
    func moveToTheGame(){
        let game = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") 
        self.view.window?.rootViewController = game
        
    }
        
    
    
    
    
}
