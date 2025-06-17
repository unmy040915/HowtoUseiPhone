//
//  TaskCompletePopup.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/17.
//

import SwiftUI

struct TaskCompletePopupView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.green)

            Text("クエストを達成しました！")
                .font(.title)
                .foregroundColor(.primary)
                .bold()
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                dismiss()
            }
        }
    }
}

#Preview {
    TaskCompletePopupView()
}
