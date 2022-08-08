//
//  RingTones.swift
//  EasyTimer
//
//  Created by SeanLi on 2022/8/7.
//

import Foundation
import AVFoundation

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
        let filePath = URL(fileURLWithPath: Bundle.main.path(forResource: resource.rawValue, ofType: "m4a")!)
        do {
            print("loading")
            let ringTone = try AVAudioPlayer(contentsOf: filePath)
            print("loaded")
            ringTone.play()
        } catch {
            print("failure")
        }
    }
}
