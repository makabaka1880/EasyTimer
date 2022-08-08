//
//  TimerView.swift
//  EasyTimer
//
//  Created by SeanLi on 2022/8/6.
//

import SwiftUI

struct TimerArc: Shape {
    var time: Double
    var total: Int
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.size.width, rect.size.height) / 2
        
        var end: Angle {
            if total == 0 {
                return Angle.degrees(360)
            } else {
                return Angle(degrees: 360 / Double(total) * time)
            }
        }
        return Path { path in
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: .zero, endAngle: end, clockwise: false)
        }
    }
}
struct TimerView: View {
    @AppStorage("theme") var theme: Themes = .none
    @Binding var time: Double
    @Binding var total: Int
    var body: some View {
        Circle()
            .strokeBorder(.ultraThickMaterial, lineWidth: 42)
            .overlay(
                TimerArc(time: time, total: total)
                    .stroke(Color(theme.rawValue), lineWidth: 12)
                    .rotationEffect(.degrees(-90))
            ).padding()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(time: .constant(.init(20)), total: .constant(.init(50))).previewDevice("iPhone 13")
        TimerView(time: .constant(.init(10)), total: .constant(.init(360)))
            .previewDevice("iPad Air (5th generation)")
    }
}
