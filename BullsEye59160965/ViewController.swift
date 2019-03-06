//
//  ViewController.swift
//  BullsEye59160965
//
//  Created by student on 9/1/2562 BE.
//  Copyright © 2562 Override. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var round: Int = 0
    var score: Int = 0
    var combo: Int = 0
    var points: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var numrandom: UILabel!
    @IBOutlet weak var numround: UILabel!
    @IBOutlet weak var numscore: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }

    @IBAction func showAlert(){
        let title = titleCh()
        let messageDf = "currentValue: \(currentValue) \n targetValue: \(targetValue) \n You scored: \(points)"
        
        let message = (combo == 0) ? messageDf : messageDf + "\n Combo: \(combo+1)"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle:.alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler:{ _ in
                                                self.nextRound()
                                            })
        
        alert.addAction(action)
        
        present(alert, animated: true,completion: nil)
        
    }
    @IBAction func sliderMoved(_ slider: UISlider){
//        print("The value of the slider is now: \(slider.value)")
        
        currentValue = lroundf(slider.value)
    }
    func startNewRound(){
        randomNum()
        currentValue = 50
        slider.value = Float(currentValue)
        score = 0
        round = 0
        combo = 0
        numscore.text = String(score)
        numround.text = String(round)
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition,forKey:nil)
    }
    func randomNum() {
        targetValue = Int.random(in: 1...100)
        numrandom.text = String(targetValue)
    }
    @IBAction func reset() {
        startNewRound()
    }
    func nextRound(){
        var difference: Int = 0
        difference = currentValue - targetValue
        difference = abs(difference)
        let point = 100
        combo = (difference == 0) ? combo + 1 : 0
        points = (point - difference) + (10*combo)
        score += points
        round += 1
        numscore.text = String(score)
        numround.text = String(round)
        randomNum()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition,forKey:nil)
        
    }
    func titleCh() -> String {
        if Int(points) == 100 {
            return "Perfect!"
        }
        else if Int(points) >= 95{
            return "You almost had it!"
        }
        else if Int(points) >= 90{
            return "Pretty good!"
        }
        else {
            return "Not even close..."
        }
        
    }
    
}


