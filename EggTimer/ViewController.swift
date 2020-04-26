//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var eggLabel: UILabel!
    @IBOutlet weak var cookProg: UIProgressView!
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player = AVAudioPlayer()
    let eggTimes : [String : Int] = ["Soft": 3, "Medium": 4, "Hard": 7]
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!

        cookProg.progress = 0.0
        secondsPassed = 0
        eggLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCnt), userInfo: nil, repeats: true)
    }
    @objc func updateCnt(){
        if(secondsPassed < totalTime){
            secondsPassed += 1
            let percentagePassed = Float(secondsPassed)/Float(totalTime)
            cookProg.progress = percentagePassed
            print(cookProg.progress)
        } else {
            //show done
            timer.invalidate()
            eggLabel.text = "DONE!"
            playDone()
        }
    }
    
    func playDone(){
        let path = Bundle.main.path(forResource: "alarm_sound", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()

        } catch {

            print ("There is an issue with this code!")

        }
    }
}
