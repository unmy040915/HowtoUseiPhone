import SwiftUI

struct TaskView: View {
    @Binding var task: String 
    var body: some View {
        ZStack{
            Rectangle()
                .frame(height: 90)
                .foregroundStyle(.black)
                .cornerRadius(16)
                .offset(x:10,y: 10)
                .padding()
            Rectangle()
                .frame(height: 90)
                .foregroundStyle(.white)
                .cornerRadius(16)
                .padding()
            Rectangle()
                .frame(height: 90)
                .foregroundStyle(.clear)
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 3)
                )
                .padding()
                
            VStack{
                Text("次のクエスト")
                    .font(.title)
                Text("\(task)")
                    .font(.system(size:32))
            }
        }

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
