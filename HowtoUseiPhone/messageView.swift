import SwiftUI

struct messageView: View {
    @Binding var selectedTab : Int
    @Binding var task: String
    
    @State private var messageText: String = ""
    @State private var messages: [String] = []
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack{
            VStack{
                TaskView(task: $task)
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .trailing, spacing: 8) {
                            ForEach(messages.indices, id: \.self) { index in
                                Text(messages[index])
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .id(index)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.indices.last, anchor: .bottom)
                        }
                    }
                }
                
                HStack {
                    TextField("メッセージを入力", text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isInputFocused)
                    
                    Button("送信") {
                        guard !messageText.isEmpty else { return }
                        messages.append(messageText)
                        messageText = ""
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
    }
    
}


#Preview {
    messageView(selectedTab: .constant(4), task: .constant(.init()))
}
