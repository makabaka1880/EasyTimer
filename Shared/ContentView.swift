//
//  ContentView.swift
//  Shared
//
//  Created by SeanLi on 2022/8/6.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var timePassed: Double = 0
    @State var stopped: Bool = false
    @State var startTheTimer: Bool = false
    @State var recieveUpdate: Bool = true
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 0.001, on: .main, in: .common)
    @AppStorage("RingTone") var ringtone: RingTones = .none
    @AppStorage("theme") var theme: Themes = .none
    @AppStorage("time") var time: Int = 0
    @AppStorage("cacheSecondsString") var cacheSecondsString: String = String(UserDefaults.standard.integer(forKey: "seconds"))
    @AppStorage("cacheMinuteString") var cacheMinutesString: String = String(UserDefaults.standard.integer(forKey: "minute"))
    @AppStorage("cacheHoursString") var cacheHoursString: String = String(UserDefaults.standard.integer(forKey: "hours"))
    @AppStorage("seconds") var seconds = UserDefaults.standard.integer(forKey: "time") % 60
    @AppStorage("minutes") var minutes = UserDefaults.standard.integer(forKey: "time") - (UserDefaults.standard.integer(forKey: "time") % 60) % 3600
    @AppStorage("hours") var hours = UserDefaults.standard.integer(forKey: "time") / 3600
    var body: some View {
        ZStack {
            TimerView(time: $timePassed, total: $time).padding()
            VStack {
                VStack {
                    if startTheTimer {
                        Text("\(clockTime(secs: time - Int(timePassed)))")
                            .font(.system(size: 25, weight: .light, design: .rounded)).fixedSize()
                    }
                    HStack {
                        TextField("Hrs...", text: $cacheHoursString)
                            .font(.system(size: 35, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                            .onSubmit {
                                let i = hours
                                if let _time = Int(cacheHoursString) {
                                    if _time != time {
                                        timePassed = 0
                                    }
                                    hours = _time
                                    time += (seconds - i) * 3600
                                }
                                cacheHoursString = String(hours)
                                print(clockTime(secs: seconds + minutes * 60 + hours * 3600))
                            }
                            .textFieldStyle(.plain)
                            .disabled(startTheTimer)
                            .fixedSize()
                        TextField("Mins...", text: $cacheMinutesString)
                            .font(.system(size: 35, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                            .onSubmit {
                                if let mins = Int(cacheMinutesString) {
                                    time += (mins - minutes) * 60
                                    minutes = mins % 60
                                    hours += mins / 60
                                }
                                update()
                            }.textFieldStyle(.plain)
                            .disabled(startTheTimer)
                            .fixedSize()
                        TextField("Secs...", text: $cacheSecondsString)
                            .font(.system(size: 35, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                            .onSubmit {
                                if let secs = Int(cacheSecondsString) {
                                    time += secs - seconds
                                    seconds = secs % 3600 % 60
                                    minutes += secs % 3600 / 60
                                    hours += secs / 3600
                                }
                                update()
                            }
                            .textFieldStyle(.plain)
                            .disabled(startTheTimer)
                    }.fixedSize()
                }.padding()
                if !(Int(timePassed) >= time) {
                    Button {
                        print("Time \(time)")
                        withAnimation {
                            if startTheTimer {
                                startTheTimer = false
                                timePassed = 0
                            } else {
                                print("schedule", seconds, minutes, hours)
                                time = seconds + minutes * 60 + hours * 3600
                                startTheTimer = true
                                stopped = false
                            }
                        }
                    } label: {
                        Label(startTheTimer ? "Stop" : "Start", systemImage: startTheTimer ? "stop.fill" : "clock").foregroundColor(Color(theme.rawValue))
                    }.buttonStyle(.plain).padding()
                }
                if startTheTimer {
                    Button {
                        withAnimation {
                            recieveUpdate.toggle()
                        }
                        if !startTheTimer {
                            stopped = false
                        }
                    } label: {
                        Label(recieveUpdate ? "Pause" : "Continue", systemImage: recieveUpdate ? "pause.fill" : "play.fill").foregroundColor(Color(theme.rawValue))
                    }.buttonStyle(.plain).padding()
                }
                if Int(timePassed) >= time {
                    Button {
                        timePassed = 0
                        stopped = false
                    } label: {
                        Label("OK", systemImage: "goforward").foregroundColor(Color(theme.rawValue))
                    }.buttonStyle(.plain).padding()
                }
            }
        }.onReceive(timer) { publisher in
            if recieveUpdate && startTheTimer {
                timePassed += 0.001
            }
            if startTheTimer {
                if Int(timePassed) >= time {
                    startTheTimer = false
                    print("done")
                    play(for: ringtone)
                }
            }
        }.task {
            _ = timer.connect()
            update()
        }.onChange(of: startTheTimer) { started in
            recieveUpdate = started
        }.onChange(of: timePassed) { __time in
            if Int(__time) >= time {
                stopped = true
            }
        }.onChange(of: stopped) { stopped in
            if stopped {
                startTheTimer = false
                print("stopped")
            }
        }
    }
    func update() {
        cacheSecondsString = String(seconds)
        cacheMinutesString = String(minutes)
        cacheHoursString = String(hours)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Air (5th generation)")
    }
}

func clockTime(secs: Int) -> String {
    let h = secs / 3600
    let m = secs % 3600 / 60
    let s = secs % 36000 % 60
    
    return "\(h):\(m):\(s)"
}

func toClock(secs: Int) -> (secs: Int, mins: Int, hours: Int) {
    let h = secs / 3600
    let m = secs % 3600 / 60
    let s = secs % 36000 % 60
    return (secs: s, mins: m, hours: h)
}

func minToClock(mins: Int) -> (mins: Int, hours: Int) {
    let secs = mins * 60
    let m = secs / 3600
    let h = secs % 3600 / 60
    return (mins: m, hours: h)
}
