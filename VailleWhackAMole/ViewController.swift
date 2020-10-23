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
    var score = Double.init()
    var fieldLabel = UILabel()
    var btn = UIButton()
    var timer = Timer()
    var winnerLabel = UILabel()
    var tauntingLabel = UILabel()
    var pointsForHit = 1.0
    var timeModifier = Double.init()
    let scoreLimit = 10
    let easyTargetUIColor = UIColor.green
    let hardTargetUIColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let screenBounds: CGRect = UIScreen.main.bounds
        screenWidth = Int(screenBounds.width)
        screenHeight = Int(screenBounds.height)
        
        fieldLabel.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight - 40)
        fieldLabel.backgroundColor = UIColor(red: (10.0 / 255.0), green: (145.0 / 255.0), blue: (0.0 / 255.0), alpha: 1.0)
        view.addSubview(fieldLabel)
        
        scoreLabel.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: screenHeight / 10)
        scoreLabel.backgroundColor = UIColor.blue
        scoreLabel.textColor = UIColor.white
        scoreLabel.text = "Score: \(score)"
        scoreLabel.textAlignment = NSTextAlignment.center
        view.addSubview(scoreLabel)
        
        btn.frame = CGRect(x: Int.random(in: 20...screenWidth - 20 - 40), y: Int.random(in: 20 + (screenHeight / 10)...screenHeight - 20 - 40), width: 40, height: 40)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = easyTargetUIColor
        btn.setImage(UIImage(named: "Mole"), for: .normal)
        btn.addTarget(self, action: #selector(hitBtn(_:)), for: .touchUpInside)
        view.addSubview(btn)
        
        tauntingLabel.frame = CGRect(x: 20, y: 20 + (screenHeight / 10), width: screenWidth, height: 20)
        tauntingLabel.textAlignment = NSTextAlignment.center
        tauntingLabel.textColor = UIColor.white
        view.addSubview(tauntingLabel)
        
        startTimer()
    }
    
    @objc func hitBtn(_ sender:UIButton!) {
        print("Button has been hit.")
        
        //Makes the mole disappear and then makes it reappear in a new randomized location.
        btn.removeFromSuperview()
        randomizeMoleLocation()
        view.addSubview(btn)
        
        //Changes the background color of the mole based on how many points it is worth.
        determineMoleColor()
        
        //Clears the taunting label text.
        tauntingLabel.text = ""
        
        //Increments the score and sets the score label text to the score.
        setScore(newScore: score + Double(pointsForHit) * timeModifier)
        
        //Restarts or resets the five second timer.
        resetTimer()
    }
    
    @objc func timerRunOut(_ sender:UIButton!) {
        print("Timer has run out.")
        
        //Makes the mole disappear.
        btn.removeFromSuperview()
        
        //Randomizes a new location for the mole and makes it appear on the screen again.
        randomizeMoleLocation()
        view.addSubview(btn)
        
        //Changes the background color of the mole based on how many points it is worth.
        determineMoleColor()
        
        //Decrements the score.
        setScore(newScore: score - 1.0)
        
        //Restarts the five second timer.
        resetTimer()
        
        //Sets the text of the taunting label.
        tauntingLabel.text = getTauntingLabelText(previousTaunt: tauntingLabel.text ?? "")
    }
    
    func getTauntingLabelText(previousTaunt: String) -> String {
        var taunts = [String]()
        taunts.append("Wow! You really missed that?")
        taunts.append("Are you even trying to hit the mole?")
        taunts.append("Is that the best you've got?")
        
        for (index, text) in taunts.enumerated() {
            if text == previousTaunt {
                taunts.remove(at: index)
            }
        }
        
        return taunts[Int.random(in: 0..<taunts.count)]
    }
    
    func randomizeMoleLocation() {
        let size = Int.random(in: 40...80)
        pointsForHit = 80.0 / Double(size)
        btn.frame = CGRect(x: Int.random(in: 20...screenWidth - 20 - size), y: Int.random(in: 20 + (screenHeight / 10)...screenHeight - 20 - size), width: size, height: size)
        btn.layer.cornerRadius = CGFloat(Double(size) / 2.0)
    }
    
    func startTimer() {
        let time = Double.random(in: 1...5)
        timeModifier = 5 / time
        timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(timerRunOut(_:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func resetTimer() {
        timer.invalidate()
        startTimer()
    }
    
    func setScore(newScore: Double) {
        score = newScore
        
        if Int(score) >= scoreLimit {
            endGame()
        } else {
            let labelScore = Double(Int(score * 100.0)) / 100.0
            scoreLabel.text = "\(labelScore)"
        }
    }
    
    func endGame() {
        print("You have won the game! Congrats!")
        
        //Do the rest of the end game code here.
        winnerLabel.frame = CGRect(x: 20, y: ((screenHeight - 40) / 2) + 20, width: screenWidth - 40, height: 40)
        winnerLabel.backgroundColor = UIColor.red
        winnerLabel.text = "You have won the game! Congrats!"
        winnerLabel.textAlignment = NSTextAlignment.center
        view.addSubview(winnerLabel)
        
        scoreLabel.removeFromSuperview()
        fieldLabel.removeFromSuperview()
        btn.removeFromSuperview()
        stopTimer()
    }
    
    func determineMoleColor() {
        if pointsForHit * timeModifier >= (2.5) {
            btn.backgroundColor = hardTargetUIColor
        } else {
            btn.backgroundColor = easyTargetUIColor
        }
    }
}
