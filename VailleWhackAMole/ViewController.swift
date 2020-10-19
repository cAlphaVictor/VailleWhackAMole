//
//  ViewController.swift
//  VailleWhackAMole
//
//  Created by Vaille, Ciaran A on 10/19/20.
//  Copyright © 2020 Vaille, Ciaran A. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var screenWidth = 0
    var screenHeight = 0
    var scoreLabel = UILabel()
    var score = Int.init()
    var fieldLabel = UILabel()
    var btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        fieldLabel.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight - 40)
        fieldLabel.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1.0)
        view.addSubview(fieldLabel)
        
        scoreLabel.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight / 10)
        scoreLabel.backgroundColor = UIColor.blue
        scoreLabel.text = "\(score)"
        view.addSubview(scoreLabel)
        
        btn.frame = CGRect(x: 20, y: 20 + (screenHeight / 10), width: 40, height: 40)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor.brown
        btn.setTitle("Mole", for: .normal)
        btn.addTarget(self, action: #selector(hitBtn(_:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func hitBtn(_ sender:UIButton!) {
        print("Button has been hit.")
        
        score += 1
        scoreLabel.text = "\(score)"
        
        btn.removeFromSuperview()
    }
}
