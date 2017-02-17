//
//  Player.swift
//  TechDra
//
//  Created by Master on 2015/03/24.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit

struct Player {
    
    var name: String = "勇者"
    var image: UIImage! = UIImage(named: "yusya.png")
    var attackPoint: Float = 30
    var speed: Float = 1.2
    var currentHP: Float = 100
    var currentTP: Float = 0//技を繰り出すためのゲージの値
    var currentMovePoint: Float = 0 //行動するためのゲージの値
    
    let maxHP: Float = 100
    let maxTP: Float = 100
    let maxMovePoint: Float = 20
    
    init(name:String, imageName:String) {
        self.name = name
        self.image = UIImage(named: imageName)
    }
}
