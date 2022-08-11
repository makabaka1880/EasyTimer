//
//  BellView.swift
//  EasyTimer
//
//  Created by SeanLi on 2022/8/7.
//

import SwiftUI

struct BellView: View {
    @State var presentSelection: Bool = false
    var body: some View {
        Image(systemName: "gear.circle").onTapGesture {
            presentSelection.toggle()
        }.sheet(isPresented: $presentSelection) {
            PickerView().padding()
        }.padding()
    }
}

struct PickerView: View {
    @AppStorage("RingTone") var ringtone: RingTones = .none
    @AppStorage("theme") var theme: Themes = .none
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            
            Picker("RingTone", selection: $ringtone) {
                ForEach(RingTones.allCases, id: \.rawValue) { item in
                    Text(item.rawValue).tag(item)
                }
            }
            #if os(macOS)
            .pickerStyle(.radioGroup)
            #else
            .pickerStyle(.wheel)
            #endif
             
            Picker("Theme", selection: $theme) {
                ForEach(Themes.allCases, id: \.rawValue) { item in
                    Text(item.rawValue).tag(item)
                }
            }
            #if os(macOS)
            .pickerStyle(.radioGroup)
            #else
            .pickerStyle(.wheel)
            #endif
            HStack {
                Spacer()
                Button("OK") {
                    dismiss()
                }
                .buttonStyle(.plain)
                .foregroundColor(Color(theme.rawValue))
                .padding()
            }
        }
    }
}
struct BellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 10).fill(.clear).ignoresSafeArea()
            BellView().padding()
        }
            .previewDevice("iPad Air (5th generation)")
        PickerView()
            .previewDevice("iPad Air (5th generation)")
    }
}
