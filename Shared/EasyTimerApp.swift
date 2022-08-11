//
//  EasyTimerApp.swift
//  Shared
//
//  Created by SeanLi on 2022/8/6.
//

import SwiftUI
#if os(macOS)
class TransparentWindowView: NSView {
  override func viewDidMoveToWindow() {
    window?.backgroundColor = .clear
    super.viewDidMoveToWindow()
  }
}

struct TransparentWindow: NSViewRepresentable {
   func makeNSView(context: Self.Context) -> NSView { return TransparentWindowView() }
   func updateNSView(_ nsView: NSView, context: Context) { }
}
struct VisualEffect: NSViewRepresentable {
   func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
   func updateNSView(_ nsView: NSView, context: Context) { }
}
#endif
struct MainView: View {
    var body: some View {
        TabView {
            ZStack(alignment: .bottomTrailing) {
                ContentView()
                BellView()
            }.tabItem {
                Label("TimeDown", systemImage: "clock")
            }
            StopwatchView().tabItem {
                Label("StopWatch", systemImage: "stopwatch")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
@main
struct EasyTimerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
