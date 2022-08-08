//
//  ClockParses.swift
//  EasyTimer
//
//  Created by SeanLi on 2022/8/7.
//

import Foundation

/*
struct ClockTime: Codable, Hashable, Identifiable {
    var id: UUID {
        get {
            return .init()
        }
    }
    var hours: Int {
        get {
            return mainSeconds / 3600
        }
        set {
            let i = hours
            mainSeconds -= i * 3600
            mainSeconds += newValue * 3600
        }
    }
    var minutes: Int {
        get {
            return (mainSeconds - seconds) / 60
        }
        set {
            let i = minutes
            let remainer = newValue % 60
            mainSeconds -= i * 60
            mainSeconds += remainer * 60
            if newValue >= 60 {
                hours += newValue / 60
            }
        }
    }
    var seconds: Int {
        get {
            return mainSeconds % 3600
        }
        set {
            let i = seconds
            let remainer = newValue % 60
            mainSeconds -= i
            mainSeconds += remainer
            if newValue >= 60 {
                minutes += newValue / 60
            }
        }
    }
    var mainSeconds: Int {
        get {
            return hours * 3600 + minutes * 60 + seconds
        }
        set {
            hours = newValue / 3600
            seconds = newValue % 3600
            minutes = (newValue - (newValue % 3600)) / 60
        }
    }
    public init(hrs: Int? = nil, mins: Int? = nil, secs: Int? = nil) {
        self.hours = hrs ?? 0
        self.minutes = mins ?? 0
        self.seconds = secs ?? 0
        self.mainSeconds = (hrs ?? 0) * 3600 + (mins ?? 0) * 60 + (secs ?? 0)
    }
    public init(secs: Int? = nil) {
        self.hours = (secs ?? 0) / 3600
        self.seconds = (secs ?? 0) % 3600
        self.minutes = ((secs ?? 0) - (secs ?? 0) % 3600) / 60
        self.mainSeconds = secs ??
    }
 }
extension ClockTime: ExpressibleByIntegerLiteral, _ExpressibleByBuiltinIntegerLiteral {
    init(integerLiteral value: Int) {
        self = .init(secs: Int(value))
    }
    
    /*
    init<T: BinaryInteger> (_builtinIntegerLiteral value: T) {
        self = .init(secs: Int(value))
    }
    */
    
    typealias IntegerLiteralType = Int
    typealias Words = Int
    typealias Magnitude = UInt
    
    init?<T>(exactly source: T) where T : BinaryInteger {
        self = .init(secs: Int(source))
    }
    
    var magnitude: UInt {
        Magnitude.init(abs(Int32(mainSeconds)))
    }
    
    static func * (lhs: ClockTime, rhs: ClockTime) -> ClockTime {
        return .init(secs: lhs.mainSeconds * rhs.mainSeconds)
    }
    
    static func *= (lhs: inout ClockTime, rhs: ClockTime) {
        lhs = .init(secs: lhs.mainSeconds * rhs.mainSeconds)
    }
    
    static func - (lhs: ClockTime, rhs: ClockTime) -> ClockTime {
        return .init(secs: lhs.mainSeconds - rhs.mainSeconds)
    }
    
    static func + (lhs: ClockTime, rhs: ClockTime) -> ClockTime {
        return .init(secs: lhs.mainSeconds + rhs.mainSeconds)
    }
}
*/
