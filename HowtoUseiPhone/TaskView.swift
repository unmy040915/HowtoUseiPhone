//
//  TaskView.swift
//  HowtoUseiPhone
//
//  Created by 牟禮優汰 on 2025/06/10.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: String
    var body: some View {
        
        Text("次の試練")
            .font(.title)
        Text("\(task)")
            .font(.system(size:32))
    }
}
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ value: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

#Preview {
    StatefulPreviewWrapper("広告を削除しよう") { task in
        TaskView(task: task)
    }
}
