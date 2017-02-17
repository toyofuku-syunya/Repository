//
//  BattleViewController.swift
//  TechMon
//
//  Created by 豊福駿也 on 2017/02/03.
//  Copyright © 2017年 Syunya Toyofuku. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    var moveValueUpTimer:Timer!//敵が攻撃するタイマー
    var enemy:Enemy=Enemy(name:"ドラゴン",imageName:"monster.png")
    var player:Player=Player(name:"勇者",imageName:"yusya.png")
    var util:TechDraUtility=TechDraUtility()
    
    var isPlayerMoveValueMax:Bool=true
    
    @IBOutlet var backgroundImageView:UIImageView!
    
    @IBOutlet var attackButton:UIButton!
    @IBOutlet var fireButton:UIButton!
    @IBOutlet var tameruButton:UIButton!
    
    @IBOutlet var enemyImageView:UIImageView!
    @IBOutlet var playerImageView:UIImageView!
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var playerHPBar:UIProgressView!
    @IBOutlet var enemyMoveBar:UIProgressView!
    @IBOutlet var playerMoveBar:UIProgressView!
    @IBOutlet var playerTPBar:UIProgressView!
    
    @IBOutlet var enemyNameLabel:UILabel!
    @IBOutlet var playerNameLabel:UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initStatus()
        moveValueUpTimer=Timer.scheduledTimer(timeInterval:0.1,target:self,selector:#selector(BattleViewController.moveValueUp),userInfo:nil,repeats:true)
        moveValueUpTimer.fire()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initStatus(){
        enemyNameLabel.text=enemy.name
        playerNameLabel.text=player.name
        
        enemyImageView.image=enemy.image
        playerImageView.image=player.image
        
        enemyHPBar.transform=CGAffineTransform(scaleX: 1.0, y: 4.0)
        playerHPBar.transform=CGAffineTransform(scaleX: 1.0, y: 4.0)
        playerTPBar.transform=CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        enemyHPBar.progress=enemy.currentHP/enemy.maxHP
        playerHPBar.progress=player.currentHP/player.maxHP
        playerTPBar.progress=player.currentTP/player.maxTP
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        util.playBGM(fileName:"BGM_battle001")
    }
    
    func moveValueUp(){
        player.currentMovePoint += 1
        playerMoveBar.progress=player.currentMovePoint/player.maxMovePoint
        
        
        if player.currentMovePoint>=player.maxMovePoint{
            isPlayerMoveValueMax=true
            player.currentMovePoint=player.maxMovePoint
        }else{
            isPlayerMoveValueMax=false
        }
        
     
        enemy.currentMovePoint += 1
        enemyMoveBar.progress=enemy.currentMovePoint/enemy.maxMovePoint
        
        if enemy.currentMovePoint>=enemy.maxMovePoint{
        self.enemyAttack()
        enemy.currentMovePoint=0
    }
}
    func enemyAttack(){
        TechDraUtility.damageAnimation(imageView:playerImageView)
        util.playSE(fileName:"SE_attack")
        
        player.currentHP -= enemy.attackPoint
        playerHPBar.setProgress(player.currentHP/player.maxHP,animated:true)
        
        if player.currentHP<=0.0{
            finishBattle(vanishImageView: playerImageView, winPlayer: false)
        }
    }
    
    @IBAction func attackaction(){
        if isPlayerMoveValueMax{
            TechDraUtility.damageAnimation(imageView: enemyImageView)
            util.playSE(fileName: "SE_attack")
            
            enemy.currentHP -= player.attackPoint
            enemyHPBar.setProgress(enemy.currentHP/enemy.maxHP, animated:true)
            
        player.currentTP += 10
            if player.currentTP >= player.maxTP{
            player.currentTP=player.maxTP
            }
        playerTPBar.progress=player.currentTP/player.maxTP
        player.currentMovePoint=0
            
            if enemy.currentHP<=0.0{
                finishBattle(vanishImageView: enemyImageView, winPlayer: true)
            }
    }
    }
    
    func finishBattle(vanishImageView:UIImageView,winPlayer:Bool){
        TechDraUtility.vanishAnimation(imageView: vanishImageView)
        util.stopBGM()
        moveValueUpTimer.invalidate()
        isPlayerMoveValueMax=false
        
        let finishedMessage:String
        if winPlayer {
            util.playSE(fileName: "SE_fanfare")
            finishedMessage="プレイヤーの勝利！"
        }else{
            util.playSE(fileName: "SE_gameover")
            finishedMessage="プレイヤーの敗北…"
        }
        let alert = UIAlertController(title:"バトル終了!",message:finishedMessage,preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"OK",style:.default,handler:{action in
            self.dismiss(animated:true,completion:nil)
        }))
            self.present(alert,animated:true,completion:nil)
    }
    
    @IBAction func fireAction(){
        if isPlayerMoveValueMax&&player.currentTP>=40{
            TechDraUtility.damageAnimation(imageView:enemyImageView)
            util.playSE(fileName: "SE_fire")
            enemy.currentHP-=100
            enemyHPBar.setProgress(enemy.currentHP/enemy.maxHP, animated: true)
            
            player.currentTP-=40
            if player.currentTP<=0{
                player.currentTP=0
            }
            playerTPBar.progress=player.currentTP/player.maxTP
            
            player.currentMovePoint=0
            
            if enemy.currentHP<=0.0{
                finishBattle(vanishImageView: enemyImageView, winPlayer: true)
            }
        }
    }
    
    @IBAction func tameru(){
        if isPlayerMoveValueMax{
            util.playSE(fileName: "SE_fire")
            
            player.currentTP+=40
            playerTPBar.progress=player.currentTP/player.maxTP
            player.currentMovePoint=0
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
