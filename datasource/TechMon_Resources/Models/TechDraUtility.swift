//
//  TechDraUtility.swift
//  TechDra
//
//  Created by Master on 2015/03/23.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit
import AVFoundation

class TechDraUtility: NSObject, AVAudioPlayerDelegate {
    
    var BGM_audioPlayer: AVAudioPlayer!
    var SE_audioPlayer: AVAudioPlayer!
    
    override init() {
        super.init()
        BGM_audioPlayer = AVAudioPlayer()
    }
    
    //MARK: Animations
    class func damageAnimation(imageView: UIImageView) {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.02
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: imageView.center.x - 5, y: imageView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: imageView.center.x + 5, y: imageView.center.y))
        imageView.layer.add(animation, forKey: "position")
        
    }
    
    class func vanishAnimation(imageView: UIImageView) {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            imageView.alpha = 0.0
            }, completion: nil)
    }

    //MARK: Sound Effects
    func playSE(fileName: String) {
        //AVAudioPlayer
        let soundFilePath = Bundle.main.path(forResource: fileName, ofType: "mp3")!
        let fileURL: URL = URL(fileURLWithPath: soundFilePath)
        /*
        //TODO: fix unwrapping error
        var error: NSError? = nil
        NSLog("%@", error!)
        */
        SE_audioPlayer = try! AVAudioPlayer(contentsOf: fileURL, fileTypeHint: nil)
        SE_audioPlayer.prepareToPlay()
        if SE_audioPlayer.isPlaying == true {
            SE_audioPlayer.currentTime = 0
        }
        SE_audioPlayer.play()
        
        /*
        // AudioToolBox
        let soundURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: "mp3")
        var mySound: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL, &mySound)
        AudioServicesPlaySystemSound(mySound);
        */
    }
    
    func playBGM(fileName: String) {

        let soundFilePath = Bundle.main.path(forResource: fileName, ofType: "mp3")!
        let fileURL: URL = URL(fileURLWithPath: soundFilePath)
        /*
        //TODO: fix unwrapping error
        var error: NSError? = nil
        NSLog("%@", error!)
        */
        self.BGM_audioPlayer = try! AVAudioPlayer(contentsOf: fileURL, fileTypeHint: nil)
        BGM_audioPlayer.numberOfLoops = -1
        BGM_audioPlayer.delegate = self
        BGM_audioPlayer.prepareToPlay()
        if BGM_audioPlayer.isPlaying == true {
            BGM_audioPlayer.currentTime = 0
        }
        
        BGM_audioPlayer.play()
    }
    
    func stopBGM() {
        BGM_audioPlayer.stop()
    }    
}
