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
@main
struct EasyTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottomTrailing) {
                ContentView()
                BellView()
            }
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
}
