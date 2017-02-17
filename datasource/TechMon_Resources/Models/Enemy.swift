//
//  Enemy.swift
//  techMon
//
//  Created by Yuki.F on 2015/10/27.
//  Copyright © 2015年 Yuki Futagami. All rights reserved.
//

import UIKit

struct Enemy {
    
    var name: String = "ドラゴン"
    var image: UIImage! = UIImage(named: "monster.png")
    var currentHP: Float = 400
    var attackPoint: Float = 20
    var speed: Float = 1.2
    var currentMovePoint: Float = 0//行動するためのゲージの値
    
    let maxMovePoint: Float = 50
    let maxHP: Float = 400
    
    init(name:String, imageName:String) {
        self.name = name
        self.image = UIImage(named: imageName)
    }
}

