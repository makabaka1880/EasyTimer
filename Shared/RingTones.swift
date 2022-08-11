//
//  RingTones.swift
//  EasyTimer
//
//  Created by SeanLi on 2022/8/7.
//

import Foundation
import AVFoundation
import SpriteKit

enum RingTones: String, CaseIterable {
    case sunshine = "Sunshine"
    case none = "No Ringtones"
}

enum Themes: String, CaseIterable {
    case sunshine = "Sunshine"
    case berry = "Berry"
    case foliage = "Foliage"
    case hadal = "Hadal"
    case none = "Default"
}

func play(for resource: RingTones) {
    if resource != .none {
        let AudioManager = SKScene()
        let player = SKSpriteNode()
        AudioManager.addChild(player)
        player.run(.repeatForever(.playSoundFileNamed("Sunshine.m4a", waitForCompletion: true)))
    }
}
