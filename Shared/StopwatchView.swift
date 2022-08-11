//
//  StopwatchView.swift
//  LightWeightTimer
//
//  Created by SeanLi on 2022/8/11.
//

import SwiftUI

struct StopwatchView: View {
    @State var timer = Timer.publish(every: UserDefaults.standard.double(forKey: "timeStepStopwatch"), on: .main, in: .common).autoconnect()
    @State var startTheTimer = false
    @State var recieveUpdate = false
    @AppStorage("timeStepStopwatch") var timestep: Double = 0.001
    @State var timePassed = 0.0
    @State var marks: [(Double, Int)] = []
    @State var markID: Int = 1
    var body: some View {
        VStack {
            HStack {
                Text(clockTimeStopWatch(secs: timePassed, stepping: 3)).font(.system(size: 35, weight: .light, design: .rounded)).fixedSize()
                .padding()
                Spacer()
            }
            HStack {
                Button {
                    if startTheTimer {
                        if recieveUpdate {
                            recieveUpdate = false
                        } else {
                            recieveUpdate = true
                        }
                    } else {
                        startTheTimer = true
                        recieveUpdate = true
                    }
                } label: {
                    Label(startTheTimer ? (recieveUpdate ? "Pause" : "Continue") : "Start", systemImage: startTheTimer ? (recieveUpdate ? "pause.fill" : "play.fill") : "stopwatch")
                }.padding()
                Spacer()
                Button {
                    if recieveUpdate {
                        marks.append((timePassed, markID))
                        markID += 1
                    } else {
                        startTheTimer = false
                        marks.removeAll()
                        timePassed = 0
                    }
                } label: {
                    Label(recieveUpdate ? "Mark" : "Stop", systemImage: startTheTimer && recieveUpdate ? "bookmark.fill" : "stop.fill")
                }.disabled(!startTheTimer).padding()
            }
            List(marks, id: \.1) { item in
                HStack {
                    Text("\(item.1)").padding()
                    Spacer()
                    Text(clockTimeStopWatch(secs: item.0, stepping: 3))
                }
            }
        }
        .onReceive(timer) { _ in
            if recieveUpdate {
                timePassed += timestep
            }
        }
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}

func clockTimeStopWatch(secs: Double, stepping step: Int) -> String {
    let seces: Int = Int(secs)
    let h = seces / 3600
    let m = seces % 3600 / 60
    let s = seces % 36000 % 60
    var secsFormatted = String(
        (
            secs - Double(
                Int(
                    secs
                )
            )
        )
            .formatted(
                .number
                    .precision(
                        .fractionLength(
                            step
                        )
                    )
            )
        )
    let _ = secsFormatted.removeFirst()
    return "\(h):\(m):\(s)\(secsFormatted)"
}

infix operator **: Power

precedencegroup Power {
    associativity: none //代表没有结合性
    higherThan: MultiplicationPrecedence
    assignment: true
}

func ** (lrs: Int, rhs: Int) -> Int {
    var number: Int = lrs
    for _ in 0...rhs {
        number *= number
    }
    return number
}
