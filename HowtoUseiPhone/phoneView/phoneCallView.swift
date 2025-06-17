//
//  phoneCallView.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/17.
//

import SwiftUI

struct phoneCallView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var task: String
    let name: String

    var body: some View {
            VStack{
                TaskView(task: $task)
                ZStack{
//                    Color(red: 128 / 255, green: 131 / 255, blue: 148 / 255)
//                        .ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Text(name)
                        .font(.title)
                        .foregroundColor(.black)
                    Text("通話中...")
                        .foregroundColor(.gray)
                    Spacer()
                        .frame(height: 40)

                    VStack {
                        HStack(spacing: 30) {
                            CallFunctionButton(icon: "mic.slash.fill", label: "消音")
                            CallFunctionButton(icon: "circle.grid.3x3.fill", label: "キーパッド")
                            CallFunctionButton(icon: "speaker.wave.2.fill", label: "スピーカー")
                        }
                        HStack(spacing: 30) {
                            CallFunctionButton(icon: "plus", label: "通話を追加")
                            CallFunctionButton(icon: "questionmark.circle", label: "FaceTime")
                            CallFunctionButton(icon: "person.crop.circle", label: "連絡先")
                        }
                    }



                    Button(action: {
                        dismiss()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 80, height: 80)
                            Image(systemName: "phone.down.fill")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    }
                }
                .padding()
            }
            


        }
    }
}


struct CallFunctionButton: View {
    let icon: String
    let label: String

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)
                Image(systemName: icon)
                    .font(.system(size: 32))
//                    .foregroundColor(.white)
            }
            Text(label)
                .font(.caption2)
//                .foregroundColor(.white)
        }
    }
}
